import 'package:revxpharma/data/api_routes/remote_data_source.dart';
import '../../../../Models/ConditionModel.dart';

abstract class ConditionTestRepository {
 Future<ConditionModel?> getConditionTest();
}

class ConditionTestRepositoryImpl implements ConditionTestRepository {
 final RemoteDataSource remoteDataSource;

 ConditionTestRepositoryImpl({required this.remoteDataSource});

 @override
 Future<ConditionModel?> getConditionTest() async {
  return await remoteDataSource.conditionTests();
 }
}
