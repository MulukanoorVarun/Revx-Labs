class DiognisticCenterModel {
  List<Diognistic>? data;
  Settings? settings;

  DiognisticCenterModel({this.data, this.settings});

  DiognisticCenterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Diognistic>[];
      json['data'].forEach((v) {
        data!.add(new Diognistic.fromJson(v));
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

class Diognistic {
  String? id;
  String? name;
  String? location;
  String? image;
  String? distance;

  Diognistic({this.id, this.name, this.location, this.image, this.distance});

  Diognistic.fromJson(Map<String, dynamic> json) {
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
