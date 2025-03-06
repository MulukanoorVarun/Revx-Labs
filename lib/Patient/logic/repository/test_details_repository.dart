import 'package:revxpharma/Models/TestDetailsModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class TestDetailsRepository{
  Future<TestDetailsModel?> getTestDetails(id);
}

class TestDetailsRepositoryImpl implements TestDetailsRepository{
  RemoteDataSource remoteDataSource;
  TestDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TestDetailsModel?> getTestDetails(id) async{
    return await remoteDataSource.getTestDetailsApi(id);
  }
}