import '../../../../Models/CartListModel.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {
  final String? testId;
  CartLoadingState({this.testId});
}


class CartSuccessState extends CartState {
  final String message;
  final int cartCount;
  final String? testId;
  final bool? isAdded;
  final int? persons;

  CartSuccessState({required this.message, required this.cartCount,required this.persons, this.testId, this.isAdded});
}

class CartLoaded extends CartState {
  final CartListModel? cartList;
  final int cartCount;
  CartLoaded(this.cartList, this.cartCount);
  @override
  List<Object?> get props => [cartList, cartCount];
}

class CartErrorState extends CartState {
  final String errorMessage;
  CartErrorState({required this.errorMessage});
}

