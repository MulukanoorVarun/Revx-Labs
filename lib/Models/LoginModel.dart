class LoginModel {
  Data? data;
  Settings? settings;

  LoginModel({this.data, this.settings});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? refresh;
  String? access;
  int? expiryTime;
  bool? isAdmin;
  bool? isSuperAdmin;
  bool? isPatient;
  String? role;

  Data(
      {this.refresh,
        this.access,
        this.expiryTime,
        this.isAdmin,
        this.isSuperAdmin,
        this.isPatient,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    expiryTime = json['expiry_time'];
    isAdmin = json['is_admin'];
    isSuperAdmin = json['is_super_admin'];
    isPatient = json['is_patient'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['expiry_time'] = this.expiryTime;
    data['is_admin'] = this.isAdmin;
    data['is_super_admin'] = this.isSuperAdmin;
    data['is_patient'] = this.isPatient;
    data['role'] = this.role;
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
