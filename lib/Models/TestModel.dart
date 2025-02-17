class TestModel {
  List<Data>? data;
  Settings? settings;

  TestModel({this.data, this.settings});

  TestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  int? price;
  String? distance;

  Data(
      {this.id,
        this.testName,
        this.diagnosticCentre,
        this.price,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    diagnosticCentre = json['diagnostic_centre'];
    price = json['price'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_name'] = this.testName;
    data['diagnostic_centre'] = this.diagnosticCentre;
    data['price'] = this.price;
    data['distance'] = this.distance;
    return data;
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

  Settings(
      {this.success,
        this.message,
        this.status,
        this.count,
        this.page,
        this.nextPage,
        this.prevPage});

  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    count = json['count'];
    page = json['page'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    data['count'] = this.count;
    data['page'] = this.page;
    data['next_page'] = this.nextPage;
    data['prev_page'] = this.prevPage;
    return data;
  }
}
