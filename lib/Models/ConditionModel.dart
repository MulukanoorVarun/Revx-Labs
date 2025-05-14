class ConditionModel {
  List<ConditionTests>? conditionTests;
  Settings? settings;

  ConditionModel({this.conditionTests, this.settings});

  ConditionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      conditionTests = <ConditionTests>[];
      json['data'].forEach((v) {
        conditionTests!.add(new ConditionTests.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conditionTests != null) {
      data['data'] = this.conditionTests!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class ConditionTests {
  String? id;
  String? name;
  int? testsAvailable;
  String? image;

  ConditionTests({this.id, this.name, this.testsAvailable, this.image});

  ConditionTests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    testsAvailable = json['tests_available'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tests_available'] = this.testsAvailable;
    data['image'] = this.image;
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
