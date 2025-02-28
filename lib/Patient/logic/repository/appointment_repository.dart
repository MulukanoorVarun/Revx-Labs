import 'package:revxpharma/Models/AppointmentDetailsModel.dart';
import 'package:revxpharma/Models/AppointmentsModel.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class AppointmentRepository {
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data);
  Future<AppointmentsModel?> fetchAppoinments();
  Future<AppointmentDetailsModel?> AppointmentDetails(id);
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final RemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data) async {
    return await remoteDataSource.bookAppointment(Data);
  }

  @override
  Future<AppointmentsModel?> fetchAppoinments() async {
    return await remoteDataSource.fetchAppointments();
  }

  @override
  Future<AppointmentDetailsModel?> AppointmentDetails(id) async {
    return await remoteDataSource.AppointmentDetails(id);
  }
}
