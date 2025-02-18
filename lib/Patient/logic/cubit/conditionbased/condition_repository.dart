import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class ConditionRepository {
  Future<ConditionBasedModel?> getConditionBased();
}

class ConditionImpl extends ConditionRepository {
  final RemoteDataSource remoteDataSource;

  ConditionImpl({required this.remoteDataSource});

  @override
  Future<ConditionBasedModel?> getConditionBased() async {
    return await remoteDataSource.fetchConditionBased();
  }
}
