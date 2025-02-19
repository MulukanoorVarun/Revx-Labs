

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  int cartCount = 0;

  CartCubit({required this.cartRepository}) : super(CartInitialState());

  // Fetch cart list
  Future<void> getCartList() async {
    emit(CartLoadingState());
    try {
     final cartList = await cartRepository.getCartList();
      if (cartList != null) {
        cartCount = cartList.data?.cartTests?.length??0;
        emit(CartLoaded(cartList, cartCount));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to fetch cart items.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  // Add item to cart
  Future<void> addToCart(Map<String, dynamic> cartData) async {
    emit(CartLoadingState());
    try {
      var response = await cartRepository.addToCart(cartData);
      if (response != null) {
        cartCount++;
        emit(CartSuccessState(message: 'Item added to cart successfully.', cartCount: cartCount));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to add item to cart.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(id) async {
    emit(CartLoadingState());
    try {
      var response = await cartRepository.removeFromCart(id);
      if (response != null) {
        cartCount = cartCount > 0 ? cartCount - 1 : 0;
        emit(CartSuccessState(message: 'Item removed from cart successfully.', cartCount: cartCount));
      } else {
        emit(CartErrorState(errorMessage: 'Failed to remove item from cart.'));
      }
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }
}

