import 'package:revxpharma/Models/SuccessModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class AppointmentRepository {
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data);
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final RemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data) async {
    return await remoteDataSource.bookAppointment(Data);
  }
}
