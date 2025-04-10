class ConditionBasedModel {
  List<ConditionBased>? data;
  Settings? settings;

  ConditionBasedModel({this.data, this.settings});

  ConditionBasedModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ConditionBased>[];
      json['data'].forEach((v) {
        data!.add(new ConditionBased.fromJson(v));
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

class ConditionBased {
  String? id;
  String? name;
  int? testsAvailable;

  ConditionBased({this.id, this.name, this.testsAvailable});

  ConditionBased.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    testsAvailable = json['tests_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tests_available'] = this.testsAvailable;
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
