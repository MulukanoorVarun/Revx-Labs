import '../../../Models/CartListModel.dart';
import '../../../Models/SuccessModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class CartRepository {
  Future<CartListModel?> getCartList();
  Future<SuccessModel?> addToCart(Map<String, dynamic> cartData);
  Future<SuccessModel?> updateCart(String id,int noOfPersons);
  Future<SuccessModel?> removeFromCart(id);
}

class CartRepositoryImpl implements CartRepository {
  final RemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CartListModel?> getCartList() async {
    return await remoteDataSource.fetchCartList();
  }

  @override
  Future<SuccessModel?> addToCart(Map<String, dynamic> cartData) async {
    return await remoteDataSource.AddToCart(cartData);
  }

  @override
  Future<SuccessModel?> updateCart(String id,int noOfPersons) async {
    return await remoteDataSource.updateCart(id,noOfPersons);
  }
  @override
  Future<SuccessModel?> removeFromCart(id) async {
    return await remoteDataSource.RemoveFromCart(id);
  }
}
