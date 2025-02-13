
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class DiagnosticDetailsRepository {
  Future<DiognisticDetailModel?> getDiagnosticDetails(id);
}

class DiagnosticDetailsRepositoryImpl implements DiagnosticDetailsRepository {
  final RemoteDataSource remoteDataSource;

  DiagnosticDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DiognisticDetailModel?> getDiagnosticDetails(id) async {
    return await remoteDataSource.fetchDiagnosticDetails(id);
  }
}