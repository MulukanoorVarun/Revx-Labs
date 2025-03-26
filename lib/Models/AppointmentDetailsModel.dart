class AppointmentDetailsModel {
  AppointmentData? appointmentData;
  Settings? settings;

  AppointmentDetailsModel({this.appointmentData, this.settings});

  AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    appointmentData = json['data'] != null ? AppointmentData.fromJson(json['data']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (appointmentData != null) {
      data['data'] = appointmentData!.toJson();
    }
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class AppointmentData {
  String? id;
  String? appointmentNumber;
  DiagnosticCentre? diagnosticCentre;
  List<AppointmentTests>? appointmentTests;
  List<AppointmentReport>? appointmentReports;
  PatientDetails? patientDetails;
  String? appointmentDate;
  String? totalAmount;

  AppointmentData({
    this.id,
    this.appointmentNumber,
    this.diagnosticCentre,
    this.appointmentTests,
    this.appointmentReports,
    this.patientDetails,
    this.appointmentDate,
    this.totalAmount,
  });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    appointmentNumber = json['appointment_number'] as String?;
    diagnosticCentre = json['diagnostic_centre'] != null
        ? DiagnosticCentre.fromJson(json['diagnostic_centre'])
        : null;
    if (json['appointment_tests'] != null) {
      appointmentTests = (json['appointment_tests'] as List)
          .map((v) => AppointmentTests.fromJson(v))
          .toList();
    }
    if (json['appointment_reports'] != null) {
      appointmentTests = (json['appointment_tests'] as List)
          .map((v) => AppointmentTests.fromJson(v))
          .toList();
    }
    patientDetails = json['patient_details'] != null
        ? PatientDetails.fromJson(json['patient_details'])
        : null;
    appointmentDate = json['appointment_date'] as String?;
    totalAmount = json['total_amount'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['appointment_number'] = appointmentNumber;
    if (diagnosticCentre != null) {
      data['diagnostic_centre'] = diagnosticCentre!.toJson();
    }
    if (appointmentTests != null) {
      data['appointment_tests'] = appointmentTests!.map((v) => v.toJson()).toList();
    }
    if (appointmentReports != null) {
      data['appointment_reports'] = appointmentReports!.map((v) => v.toJson()).toList();
    }
    if (patientDetails != null) {
      data['patient_details'] = patientDetails!.toJson();
    }
    data['appointment_date'] = appointmentDate;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class AppointmentReport {
  String? reportId;
  String? reportUrl;

  AppointmentReport({this.reportId, this.reportUrl});

  AppointmentReport.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'] as String?;
    reportUrl = json['report_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['report_id'] = reportId;
    data['report_url'] = reportUrl;
    return data;
  }
}

class DiagnosticCentre {
  String? id;
  String? name;
  String? location;
  String? image;
  String? distance;

  DiagnosticCentre({
    this.id,
    this.name,
    this.location,
    this.image,
    this.distance,
  });

  DiagnosticCentre.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    location = json['location'] as String?;
    image = json['image'] as String?;
    distance = json['distance'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['image'] = image;
    data['distance'] = distance;
    return data;
  }
}

class AppointmentTests {
  String? id;
  TestDetails? testDetails;
  int? noOfPersons;
  int? totalPrice;

  AppointmentTests({
    this.id,
    this.testDetails,
    this.noOfPersons,
    this.totalPrice,
  });

  AppointmentTests.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    testDetails = json['test_details'] != null
        ? TestDetails.fromJson(json['test_details'])
        : null;
    noOfPersons = json['no_of_persons'] as int?;
    totalPrice = json['total_price'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (testDetails != null) {
      data['test_details'] = testDetails!.toJson();
    }
    data['no_of_persons'] = noOfPersons;
    data['total_price'] = totalPrice;
    return data;
  }
}

class TestDetails {
  String? id;
  String? diagnosticCentre;
  String? distance;
  bool? existInCart;
  int? noOfPersons;
  TestDetailsModelClass? testDetailsModel; // Added to handle nested test_details

  TestDetails({
    this.id,
    this.diagnosticCentre,
    this.distance,
    this.existInCart,
    this.noOfPersons,
    this.testDetailsModel,
  });

  TestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    diagnosticCentre = json['diagnostic_centre'] as String?;
    distance = json['distance'] as String?;
    existInCart = json['exist_in_cart'] as bool?;
    noOfPersons = json['no_of_persons'] as int?;
    testDetailsModel = json['test_details'] != null
        ? TestDetailsModelClass.fromJson(json['test_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['diagnostic_centre'] = diagnosticCentre;
    data['distance'] = distance;
    data['exist_in_cart'] = existInCart;
    data['no_of_persons'] = noOfPersons;
    if (testDetailsModel != null) {
      data['test_details'] = testDetailsModel!.toJson();
    }
    return data;
  }
}

class TestDetailsModelClass {
  String? id;
  String? testName;
  String? category;
  int? price;
  String? condition;
  bool? fastingRequired;
  int? reportsDeliveredIn;
  String? image;
  int? noOfTests;

  TestDetailsModelClass({
    this.id,
    this.testName,
    this.category,
    this.price,
    this.condition,
    this.fastingRequired,
    this.reportsDeliveredIn,
    this.image,
    this.noOfTests,
  });

  TestDetailsModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    testName = json['test_name'] as String?;
    category = json['category'] as String?;
    price = json['price'] as int?;
    condition = json['condition'] as String?;
    fastingRequired = json['fasting_required'] as bool?;
    reportsDeliveredIn = json['reports_delivered_in'] as int?;
    image = json['image'] as String?;
    noOfTests = json['no_of_tests'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['test_name'] = testName;
    data['category'] = category;
    data['price'] = price;
    data['condition'] = condition;
    data['fasting_required'] = fastingRequired;
    data['reports_delivered_in'] = reportsDeliveredIn;
    data['image'] = image;
    data['no_of_tests'] = noOfTests;
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

  PatientDetails({
    this.id,
    this.patientName,
    this.mobile,
    this.dob,
    this.bloodGroup,
    this.gender,
    this.age,
  });

  PatientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    patientName = json['patient_name'] as String?;
    mobile = json['mobile'] as String?;
    dob = json['dob'] as String?;
    bloodGroup = json['blood_group'] as String?;
    gender = json['gender'] as String?;
    age = json['age'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['patient_name'] = patientName;
    data['mobile'] = mobile;
    data['dob'] = dob;
    data['blood_group'] = bloodGroup;
    data['gender'] = gender;
    data['age'] = age;
    return data;
  }
}

class Settings {
  int? success;
  String? message;
  int? status;

  Settings({this.success, this.message, this.status});

  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'] as int?;
    message = json['message'] as String?;
    status = json['status'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}