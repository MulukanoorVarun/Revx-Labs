import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class RadiologyTestRepository {
 Future<TestModel?> getRadiologyTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId);
}

class RadiologyTestRepositoryImpl implements RadiologyTestRepository {
 final RemoteDataSource remoteDataSource;

 RadiologyTestRepositoryImpl({required this.remoteDataSource});

 @override
 Future<TestModel?> getRadiologyTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId) async {
  return await remoteDataSource.radiologyTest(latlang,catId,search_Query,page,diagnosticID,scanId,x_rayId);
 }
}
