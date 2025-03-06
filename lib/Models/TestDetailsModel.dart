class TestDetailsModel {
  Data? data;
  Settings? settings;

  TestDetailsModel({this.data, this.settings});

  TestDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? testName;
  String? diagnosticCentre;
  String? price;
  String? distance;
  int? noOfTests;
  List<String>? subTests;
  bool? existInCart;
  String? purposeDescription;
  String? parameters;
  String? procedureDescription;

  Data(
      {this.id,
        this.testName,
        this.diagnosticCentre,
        this.price,
        this.distance,
        this.noOfTests,
        this.subTests,
        this.existInCart,
        this.purposeDescription,
        this.parameters,
        this.procedureDescription});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    diagnosticCentre = json['diagnostic_centre'];
    price = json['price'];
    distance = json['distance'];
    noOfTests = json['no_of_tests'];
    subTests = json['sub_tests'].cast<String>();
    existInCart = json['exist_in_cart'];
    purposeDescription = json['purpose_description'];
    parameters = json['parameters'];
    procedureDescription = json['procedure_description'];
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
    data['purpose_description'] = this.purposeDescription;
    data['parameters'] = this.parameters;
    data['procedure_description'] = this.procedureDescription;
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
