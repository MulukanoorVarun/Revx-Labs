class TestModel {
  List<Data>? data;
  Settings? settings;

  TestModel({this.data, this.settings});

  TestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    if (this.data != null) {
      dataMap['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      dataMap['settings'] = this.settings!.toJson();
    }
    return dataMap;
  }
}

class Data {
  String? id;
  String? testName;
  String? diagnosticCentre;
  String? price;
  String? distance;
  bool? existInCart;
  int? noOfPersons;
  List<String>? subTests;
  TestDetails? testDetails;

  Data({
    this.id,
    this.testName,
    this.diagnosticCentre,
    this.price,
    this.distance,
    this.existInCart,
    this.noOfPersons,
    this.subTests,
    this.testDetails,
  });

  // CopyWith method to clone an object and update specific fields
  Data copyWith({
    String? id,
    String? testName,
    String? diagnosticCentre,
    String? price,
    String? distance,
    bool? existInCart,
    int? noOfPersons,
    List<String>? subTests,
    TestDetails? testDetails,
  }) {
    return Data(
      id: id ?? this.id,
      testName: testName ?? this.testName,
      diagnosticCentre: diagnosticCentre ?? this.diagnosticCentre,
      price: price ?? this.price,
      distance: distance ?? this.distance,
      existInCart: existInCart ?? this.existInCart,
      noOfPersons: noOfPersons ?? this.noOfPersons,
      subTests: subTests ?? this.subTests,
      testDetails: testDetails ?? this.testDetails,
    );
  }

  // fromJson to convert JSON to Data object
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    diagnosticCentre = json['diagnostic_centre'];
    price = json['price'];
    distance = json['distance'];
    existInCart = json['exist_in_cart'];
    noOfPersons = json['no_of_persons'];
    subTests = json['sub_tests'] != null
        ? List<String>.from(json['sub_tests'])
        : null;
    testDetails = json['test_details'] != null
        ? TestDetails.fromJson(json['test_details'])
        : null;
  }

  // toJson to convert Data object to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['id'] = id;
    dataMap['test_name'] = testName;
    dataMap['diagnostic_centre'] = diagnosticCentre;
    dataMap['price'] = price;
    dataMap['distance'] = distance;
    dataMap['exist_in_cart'] = existInCart;
    dataMap['no_of_persons'] = noOfPersons;
    dataMap['sub_tests'] = subTests;
    if (testDetails != null) {
      dataMap['test_details'] = testDetails!.toJson();
    }
    return dataMap;
  }
}

class TestDetails {
  String? id;
  String? testName;
  String? category;
  int? price;
  String? condition;
  bool? fastingRequired;
  int? reportsDeliveredIn;
  String? image;
  int? noOfTests;

  TestDetails({
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

  // fromJson to convert JSON to TestDetails object
  TestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    category = json['category'];
    price = json['price'];
    condition = json['condition'];
    fastingRequired = json['fasting_required'];
    reportsDeliveredIn = json['reports_delivered_in'];
    image = json['image'];
    noOfTests = json['no_of_tests'];
  }

  // toJson to convert TestDetails object to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['id'] = this.id;
    dataMap['test_name'] = this.testName;
    dataMap['category'] = this.category;
    dataMap['price'] = this.price;
    dataMap['condition'] = this.condition;
    dataMap['fasting_required'] = this.fastingRequired;
    dataMap['reports_delivered_in'] = this.reportsDeliveredIn;
    dataMap['image'] = this.image;
    dataMap['no_of_tests'] = this.noOfTests;
    return dataMap;
  }
}

class Settings {
  int? success;
  String? message;
  int? status;
  int? count;
  int? page;
  bool? nextPage;
  bool? prevPage;

  Settings({
    this.success,
    this.message,
    this.status,
    this.count,
    this.page,
    this.nextPage,
    this.prevPage,
  });

  // fromJson to convert JSON to Settings object
  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    count = json['count'];
    page = json['page'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  // toJson to convert Settings object to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['success'] = this.success;
    dataMap['message'] = this.message;
    dataMap['status'] = this.status;
    dataMap['count'] = this.count;
    dataMap['page'] = this.page;
    dataMap['next_page'] = this.nextPage;
    dataMap['prev_page'] = this.prevPage;
    return dataMap;
  }
}
