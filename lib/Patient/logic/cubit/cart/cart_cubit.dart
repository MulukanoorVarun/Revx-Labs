

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/cart_repository.dart';
import '../tests/test_cubit.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final TestCubit testCubit; // Inject TestCubit here
  int cartCount = 0;

  CartCubit({required this.cartRepository, required this.testCubit})
      : super(CartInitialState());

  // Fetch cart list
  Future<void> getCartList() async {
    emit(CartLoadingState());
    try {
      final cartList = await cartRepository.getCartList();
      if (cartList != null) {
        cartCount = cartList.data?.cartTests?.length ?? 0;
        emit(CartLoaded(cartList, cartCount));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to fetch cart items.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addToCart(Map<String, dynamic> cartData, BuildContext context) async {
    emit(CartLoadingState(testId: cartData['test']));
    try {
      var response = await cartRepository.addToCart(cartData);
      if (response?.settings?.success == 1) {
        // Pass context from UI to update TestCubit
        context.read<TestCubit>().updateTestCartStatus(
          testId: cartData['test'],
          isAdded: true,
        );
        emit(CartSuccessState(
          message: 'Item added to cart successfully.',
          cartCount: ++cartCount,
          testId: cartData['test'],
          isAdded: true,
        ));
      } else {
        emit(CartErrorState(errorMessage: '${response?.settings?.message}'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> removeFromCart(String id, BuildContext context) async {
    emit(CartLoadingState(testId: id));
    try {
      var response = await cartRepository.removeFromCart(id);
      if (response?.settings?.success == 1) {
        context.read<TestCubit>().updateTestCartStatus(
          testId: id,
          isAdded: false,
        );
        emit(CartSuccessState(
          message: 'Item removed from cart successfully.',
          cartCount: --cartCount,
          testId: id,
          isAdded: false,
        ));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to remove item from cart.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

}


