class PatientsListModel {
  List<Patient>? patientslist;
  Settings? settings;

  PatientsListModel({this.patientslist, this.settings});

  PatientsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      patientslist = <Patient>[];
      json['data'].forEach((v) {
        patientslist!.add(new Patient.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientslist != null) {
      data['data'] = this.patientslist!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Patient {
  String? id;
  String? patientName;
  String? mobile;
  String? dob;
  String? bloodGroup;
  String? gender;
  int? age;

  Patient(
      {this.id,
        this.patientName,
        this.mobile,
        this.dob,
        this.bloodGroup,
        this.gender,
        this.age});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    mobile = json['mobile'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_name'] = this.patientName;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['blood_group'] = this.bloodGroup;
    data['gender'] = this.gender;
    data['age'] = this.age;
    return data;
  }
}

class Settings {
  int? success;
  String? message;
  int? status;

  Settings({this.success, this.message, this.status});

  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
