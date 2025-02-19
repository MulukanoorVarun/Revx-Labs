
import '../../../Models/PatientsListModel.dart';
import '../../../Models/SuccessModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class PatientRepository {
  Future<PatientsListModel?> getPatients();
  Future<SuccessModel?> addPatient();
  Future<SuccessModel?> editPatient();
  Future<SuccessModel?> deletePatient();
}

class PatientRepositoryImpl implements PatientRepository {
  final RemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PatientsListModel?> getPatients() async {
    return await remoteDataSource.fetchPatients();
  }

  @override
  Future<SuccessModel?> addPatient() async {
    return await remoteDataSource.AddPatient();
  }


  @override
  Future<SuccessModel?> editPatient() async {
    return await remoteDataSource.UpdatePatient();
  }


  @override
  Future<SuccessModel?> deletePatient() async {
    return await remoteDataSource.DeletePatient();
  }
}