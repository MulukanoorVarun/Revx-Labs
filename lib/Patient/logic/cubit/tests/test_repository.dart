import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class TestRepository {
 Future<TestModel?> getTest(latlang,catId);
}

class TestRepositoryImpl implements TestRepository {
 final RemoteDataSource remoteDataSource;

 TestRepositoryImpl({required this.remoteDataSource});

 @override
 Future<TestModel?> getTest(latlang,catId) async {
  return await remoteDataSource.fetchTest(latlang,catId);
 }
}
