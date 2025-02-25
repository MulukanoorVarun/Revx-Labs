class CartListModel {
  Data? data;
  Settings? settings;

  CartListModel({this.data, this.settings});

  CartListModel.fromJson(Map<String, dynamic> json) {
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
  List<CartTests>? cartTests;
  DiagnosticCentre? diagnosticCentre;
  dynamic                                                                                                                                                totalAmount;

  Data({this.cartTests, this.diagnosticCentre, this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_tests'] != null) {
      cartTests = <CartTests>[];
      json['cart_tests'].forEach((v) {
        cartTests!.add(new CartTests.fromJson(v));
      });
    }
    diagnosticCentre = json['diagnostic_centre'] != null
        ? new DiagnosticCentre.fromJson(json['diagnostic_centre'])
        : null;
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartTests != null) {
      data['cart_tests'] = this.cartTests!.map((v) => v.toJson()).toList();
    }
    if (this.diagnosticCentre != null) {
      data['diagnostic_centre'] = this.diagnosticCentre!.toJson();
    }
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class CartTests {
  String? id;
  String? testId;
  String? testName;
  String? testPrice;

  CartTests({this.id, this.testId, this.testName, this.testPrice});

  CartTests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    testName = json['test_name'];
    testPrice = json['test_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['test_name'] = this.testName;
    data['test_price'] = this.testPrice;
    return data;
  }
}

class DiagnosticCentre {
  String? id;
  String? name;
  String? location;
  String? image;
  String? distance;

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
