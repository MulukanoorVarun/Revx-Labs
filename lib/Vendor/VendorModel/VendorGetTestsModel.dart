class VendorGetTestsModel {
  List<VendorGetTest>? data;
  Settings? settings;

  VendorGetTestsModel({this.data, this.settings});

  VendorGetTestsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VendorGetTest>[];
      json['data'].forEach((v) {
        data!.add(new VendorGetTest.fromJson(v));
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

class VendorGetTest {
  String? id;
  String? testName;
  String? category;
  String? price;

  VendorGetTest({this.id, this.testName, this.category, this.price});

  VendorGetTest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    category = json['category'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_name'] = this.testName;
    data['category'] = this.category;
    data['price'] = this.price;
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
