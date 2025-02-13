
import '../../../Models/BannersModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class BannersRepository {
  Future<BannersModel?> getBanners();
}

class BannersRepositoryImpl implements BannersRepository {
  final RemoteDataSource remoteDataSource;

  BannersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BannersModel?> getBanners() async {
    return await remoteDataSource.fetchBanners();
  }
}