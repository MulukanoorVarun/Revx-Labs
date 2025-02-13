import '../../../Models/CategoryModel.dart';
import '../../../Models/DiognisticCenterModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class DiagnosticCenterRepository {
  Future<DiognisticCenterModel?> getDiagnosticCenters();
}

class DiagnosticCenterRepositoryImpl implements DiagnosticCenterRepository {
  final RemoteDataSource remoteDataSource;

  DiagnosticCenterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DiognisticCenterModel?> getDiagnosticCenters() async {
    return await remoteDataSource.fetchDiagnosticCenters();
  }
}