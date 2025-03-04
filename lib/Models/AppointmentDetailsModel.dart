class AppointmentDetailsModel {
  AppointmentData? appointment_data;
  Settings? settings;

  AppointmentDetailsModel({this.appointment_data, this.settings});

  AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    appointment_data = json['data'] != null ? new AppointmentData.fromJson(json['data']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointment_data != null) {
      data['data'] = this.appointment_data!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class AppointmentData {
  String? id;
  String? appointmentNumber;
  DiagnosticCentre? diagnosticCentre;
  List<AppointmentTests>? appointmentTests;
  List<Null>? appointmentReports;
  PatientDetails? patientDetails;
  String? appointmentDate;
  String? totalAmount;

  AppointmentData(
      {this.id,
        this.appointmentNumber,
        this.diagnosticCentre,
        this.appointmentTests,
        this.appointmentReports,
        this.patientDetails,
        this.appointmentDate,
        this.totalAmount});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentNumber = json['appointment_number'];
    diagnosticCentre = json['diagnostic_centre'] != null
        ? new DiagnosticCentre.fromJson(json['diagnostic_centre'])
        : null;
    if (json['appointment_tests'] != null) {
      appointmentTests = <AppointmentTests>[];
      json['appointment_tests'].forEach((v) {
        appointmentTests!.add(new AppointmentTests.fromJson(v));
      });
    }
    if (json['appointment_reports'] != null) {
      appointmentTests = <AppointmentTests>[];
      json['appointment_tests'].forEach((v) {
        appointmentTests!.add(new AppointmentTests.fromJson(v));
      });
    }
    patientDetails = json['patient_details'] != null
        ? new PatientDetails.fromJson(json['patient_details'])
        : null;
    appointmentDate = json['appointment_date'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_number'] = this.appointmentNumber;
    if (this.diagnosticCentre != null) {
      data['diagnostic_centre'] = this.diagnosticCentre!.toJson();
    }
    if (this.appointmentTests != null) {
      data['appointment_tests'] =
          this.appointmentTests!.map((v) => v.toJson()).toList();
    }
    if (this.appointmentReports != null) {
      data['appointment_reports'] =
          this.appointmentTests!.map((v) => v.toJson()).toList();
    }
    if (this.patientDetails != null) {
      data['patient_details'] = this.patientDetails!.toJson();
    }
    data['appointment_date'] = this.appointmentDate;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class DiagnosticCentre {
  String? id;
  String? name;
  String? location;
  String? image;
  Null? distance;

  DiagnosticCentre(
      {this.id, this.name, this.location, this.image, this.distance});

  DiagnosticCentre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['image'] = this.image;
    data['distance'] = this.distance;
    return data;
  }
}

class AppointmentTests {
  String? id;
  String? testName;
  String? diagnosticCentre;
  String? price;
  Null? distance;
  int? noOfTests;
  List<String>? subTests;
  bool? existInCart;

  AppointmentTests(
      {this.id,
        this.testName,
        this.diagnosticCentre,
        this.price,
        this.distance,
        this.noOfTests,
        this.subTests,
        this.existInCart});

  AppointmentTests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    diagnosticCentre = json['diagnostic_centre'];
    price = json['price'];
    distance = json['distance'];
    noOfTests = json['no_of_tests'];
    subTests = json['sub_tests'].cast<String>();
    existInCart = json['exist_in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_name'] = this.testName;
    data['diagnostic_centre'] = this.diagnosticCentre;
    data['price'] = this.price;
    data['distance'] = this.distance;
    data['no_of_tests'] = this.noOfTests;
    data['sub_tests'] = this.subTests;
    data['exist_in_cart'] = this.existInCart;
    return data;
  }
}

class PatientDetails {
  String? id;
  String? patientName;
  String? mobile;
  String? dob;
  String? bloodGroup;
  String? gender;
  int? age;

  PatientDetails(
      {this.id,
        this.patientName,
        this.mobile,
        this.dob,
        this.bloodGroup,
        this.gender,
        this.age});

  PatientDetails.fromJson(Map<String, dynamic> json) {
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
