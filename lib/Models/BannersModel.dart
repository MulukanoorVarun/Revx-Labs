class BannersModel {
  List<Banners>? data;
  Settings? settings;

  BannersModel({this.data, this.settings});

  BannersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Banners>[];
      json['data'].forEach((v) {
        data!.add(new Banners.fromJson(v));
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

class Banners {
  String? id;
  String? bannerName;
  String? image;
  String? url;

  Banners({this.id, this.bannerName, this.image, this.url});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['image'] = this.image;
    data['url'] = this.url;
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
