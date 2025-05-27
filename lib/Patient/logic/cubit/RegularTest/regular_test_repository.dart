import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class RegularTestRepository {
 Future<TestModel?> getRegularTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId);

}

class RegularTestRepositoryImpl implements RegularTestRepository {
 final RemoteDataSource remoteDataSource;

 RegularTestRepositoryImpl({required this.remoteDataSource});

 @override
 Future<TestModel?> getRegularTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId) async {
  return await remoteDataSource.fetchRegularTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId);
 }
}
