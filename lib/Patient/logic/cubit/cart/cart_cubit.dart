import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Models/CartListModel.dart';
import '../../repository/cart_repository.dart';
import '../test_details/test_details_cubit.dart';
import '../tests/test_cubit.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final TestCubit testCubit;
  final TestDetailsCubit testDetailsCubit;
  int cartCount = 0;
  CartListModel? cartListModel; // Store the current cart data

  CartCubit(
      {required this.cartRepository,
      required this.testCubit,
      required this.testDetailsCubit})
      : super(CartInitialState());

  // Fetch cart list
  Future<void> getCartList() async {
    emit(CartLoadingState());
    try {
      final cartList = await cartRepository.getCartList();
      if (cartList != null) {
        cartCount = cartList.data?.cartTests?.length ?? 0;
        cartListModel = cartList; // Store cart data
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
        cartCount++;
        testCubit.updateTestCartStatus(
          testId: cartData['test'],
          persons: cartData['no_of_persons'],
          isAdded: true,
        );
        testDetailsCubit.updateTestCartStatus(
            isAdded: true,
            persons: cartData['no_of_persons'],
            testId: cartData['test']);
        await getCartList(); // Refresh cart list after adding
        emit(CartSuccessState(
          message: 'Item added to cart successfully.',
          cartCount: cartCount,
          testId: cartData['test'],
          persons: cartData['no_of_persons'],
          isAdded: true,
        ));
      } else {
        emit(CartErrorState(
            errorMessage:
                response?.settings?.message ?? 'Failed to add item.'));
        emit(CartLoaded(cartListModel, cartCount)); // Preserve cart data
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
      emit(CartLoaded(cartListModel, cartCount));
    }
  }

  Future<void> updateCart(String id, int noOfPersons) async {
    emit(CartLoadingState(testId: id));
    try {
      final response = await cartRepository.updateCart(id, noOfPersons);
      if (response?.settings?.success == 1) {
        // ✅ Update the cart data correctly
        cartListModel?.data?.cartTests =
            cartListModel?.data?.cartTests?.map((test) {
          if (test.testId == id) {
            print(
                "[CartCubit] Updating Test ID: $id to noOfPersons: $noOfPersons");
            return test.copyWith(noOfPersons: noOfPersons); // Correctly update count
          }
          return test;
        }).toList();
        // ✅ Update the test cart status in TestCubit
        testCubit.updateTestCartStatus(
          testId: id,
          persons: noOfPersons,
          isAdded: true,
        );
        testDetailsCubit.updateTestCartStatus(
            isAdded: true,
            persons: noOfPersons,
            testId: id);
        emit(CartSuccessState(
          message: 'Cart updated successfully.',
          cartCount: cartCount,
          testId: id,
          persons: noOfPersons,
          isAdded: true,
        ));
        // ✅ Emit updated state after modification
        emit(CartLoaded(cartListModel, cartCount));
        getCartList();
      } else {
        emit(CartErrorState(
            errorMessage:
                response?.settings?.message ?? 'Failed to update item.'));
        emit(CartLoaded(cartListModel, cartCount));
      }
    } catch (e) {
      print("[CartCubit] Exception: $e");
      emit(CartErrorState(errorMessage: e.toString()));
      emit(CartLoaded(cartListModel, cartCount));
    }
  }

  Future<void> removeFromCart(String id) async {
    emit(CartLoadingState(testId: id));
    try {
      final response = await cartRepository.removeFromCart(id);
      if (response?.settings?.success == 1) {
        cartCount--;
        // Remove the test from cartTests list
        cartListModel?.data?.cartTests
            ?.removeWhere((test) => test.testId == id);
        testCubit.updateTestCartStatus(
          testId: id,
          isAdded: false,
          persons: 0,
        );
        testDetailsCubit.updateTestCartStatus(
            isAdded: false,
            persons: 0,
            testId: id);
        emit(CartSuccessState(
          message: 'Item removed from cart successfully.',
          cartCount: cartCount,
          testId: id,
          persons: 0,
          isAdded: false,
        ));
        emit(CartLoaded(cartListModel, cartCount)); // Emit updated cart
      } else {
        emit(CartErrorState(errorMessage: 'Failed to remove item.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }
}
