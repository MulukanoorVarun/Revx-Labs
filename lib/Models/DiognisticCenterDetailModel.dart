class DiognisticDetailModel {
  Diognostic_details? diognostic_details;
  Settings? settings;

  DiognisticDetailModel({this.diognostic_details, this.settings});

  DiognisticDetailModel.fromJson(Map<String, dynamic> json) {
    diognostic_details = json['data'] != null ? new Diognostic_details.fromJson(json['data']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diognostic_details != null) {
      data['data'] = this.diognostic_details!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Diognostic_details {
  String? id;
  String? image;
  String? name;
  String? location;
  List<String>? daysOpened;
  String? startTime;
  String? endTime;
  String? description;
  String? contactPerson;
  String? contactMobile;
  String? registrationNumber;

  Diognostic_details(
      {this.id,
        this.image,
        this.name,
        this.location,
        this.daysOpened,
        this.startTime,
        this.endTime,
        this.description,
        this.contactPerson,
        this.contactMobile,
        this.registrationNumber});

  Diognostic_details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    location = json['location'];
    daysOpened = json['days_opened'].cast<String>();
    startTime = json['start_time'];
    endTime = json['end_time'];
    description = json['description'];
    contactPerson = json['contact_person'];
    contactMobile = json['contact_mobile'];
    registrationNumber = json['registration_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['location'] = this.location;
    data['days_opened'] = this.daysOpened;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['description'] = this.description;
    data['contact_person'] = this.contactPerson;
    data['contact_mobile'] = this.contactMobile;
    data['registration_number'] = this.registrationNumber;
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
