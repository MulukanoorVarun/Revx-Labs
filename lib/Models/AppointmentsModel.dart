class AppointmentsModel {
  List<Appointments>? appointments;
  Settings? settings;

  AppointmentsModel({this.appointments, this.settings});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      appointments = <Appointments>[];
      json['data'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointments != null) {
      data['data'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Appointments {
  String? id;
  String? appointmentNumber;
  String? diagnosticCentreName;
  String? appointmentDate;
  String? totalAmount;

  Appointments(
      {this.id,
        this.appointmentNumber,
        this.diagnosticCentreName,
        this.appointmentDate,
        this.totalAmount});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentNumber = json['appointment_number'];
    diagnosticCentreName = json['diagnostic_centre_name'];
    appointmentDate = json['appointment_date'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_number'] = this.appointmentNumber;
    data['diagnostic_centre_name'] = this.diagnosticCentreName;
    data['appointment_date'] = this.appointmentDate;
    data['total_amount'] = this.totalAmount;
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
