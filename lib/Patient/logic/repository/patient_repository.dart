
import 'package:revxpharma/Models/getPatientDetailModel.dart';

import '../../../Models/PatientsListModel.dart';
import '../../../Models/SuccessModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class PatientRepository {
  Future<PatientsListModel?> getPatients();
  Future<SuccessModel?> addPatient(Map<String, dynamic> patientData);
  Future<SuccessModel?> editPatient(Map<String, dynamic> patientData,id);
  Future<SuccessModel?> deletePatient(id);
  Future<getPatientDetailModel?> patient_details(id);
  Future<getPatientDetailModel?> defaultPatientDetails();
}

class PatientRepositoryImpl implements PatientRepository {
  final RemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PatientsListModel?> getPatients() async {
    return await remoteDataSource.fetchPatients();
  }

  @override
  Future<SuccessModel?> addPatient(Map<String, dynamic> patientData) async {
    return await remoteDataSource.AddPatient(patientData);
  }


  @override
  Future<SuccessModel?> editPatient(Map<String, dynamic> patientData,id) async {
    return await remoteDataSource.UpdatePatient(patientData,id);
  }


  @override
  Future<SuccessModel?> deletePatient(id) async {
    return await remoteDataSource.DeletePatient(id);
  }

  @override
  Future<getPatientDetailModel?> patient_details(id) async {
    return await remoteDataSource.GetPatientDetails(id);
  }

  @override
  Future<getPatientDetailModel?> defaultPatientDetails() async {
    return await remoteDataSource.GetDefaultPatientDetails();
  }
}