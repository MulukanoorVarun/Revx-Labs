

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

  Future<void> addToCart(Map<String, dynamic> cartData) async {
    emit(CartLoadingState(testId: cartData['test']));
    try {
      final response = await cartRepository.addToCart(cartData);
      if (response?.settings?.success == 1) {
        // Update count only if API succeeds
        cartCount++;
        testCubit.updateTestCartStatus(
          testId: cartData['test'],
          persons: cartData['no_of_persons'],
          isAdded: true,
        );
        emit(CartSuccessState(
          message: 'Item added to cart successfully.',
          cartCount: cartCount,
          testId: cartData['test'],
          persons: cartData['no_of_persons'],
          isAdded: true,
        ));
      } else {
        // Emit failure but retain previous count
        emit(CartErrorState(
          errorMessage: response?.settings?.message ?? 'Failed to add item.',
        ));
        emit(CartLoaded(null, cartCount)); // Preserve current cart count
      }
    } catch (e) {
      // Handle exceptions and preserve count
      emit(CartErrorState(errorMessage: e.toString()));
      emit(CartLoaded(null, cartCount));
    }
  }

  Future<void> updateCart(String id, int no_of_persons) async {
    emit(CartLoadingState(testId: id));
    try {
      final response = await cartRepository.updateCart(id,no_of_persons);
      if (response?.settings?.success == 1) {
        // Update count only if API succeeds
        cartCount++;
        testCubit.updateTestCartStatus(
          testId:  id,
          persons: no_of_persons,
          isAdded: true,
        );
        emit(CartSuccessState(
          message: 'Cart Updated successfully.',
          cartCount: cartCount,
          testId: id,
          persons: no_of_persons,
          isAdded: true,
        ));
      } else {
        // Emit failure but retain previous count
        emit(CartErrorState(
          errorMessage: response?.settings?.message ?? 'Failed to update item.',
        ));
        emit(CartLoaded(null, cartCount)); // Preserve current cart count
      }
    } catch (e) {
      // Handle exceptions and preserve count
      emit(CartErrorState(errorMessage: e.toString()));
      emit(CartLoaded(null, cartCount));
    }
  }


  // Remove from cart with cart count update only on success
  Future<void> removeFromCart(String id) async {
    emit(CartLoadingState(testId: id));
    try {
      final response = await cartRepository.removeFromCart(id);
      if (response?.settings?.success == 1) {
        // Update count only after success
        getCartList();
        cartCount--;
        // ✅ Directly use `testCubit` instead of `context.read<TestCubit>()`
        testCubit.updateTestCartStatus(
          testId: id,
          isAdded: false,
          persons: 0,
        );

        emit(CartSuccessState(
          message: 'Item removed from cart successfully.',
          cartCount: cartCount,
          testId: id,
          persons: 0,
          isAdded: false,
        ));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to remove item.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }
}


