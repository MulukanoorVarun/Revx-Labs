class SuccessModel {
  final Data? data;
  final Settings? settings;

  SuccessModel({this.data, this.settings});

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      settings: json['settings'] != null ? Settings.fromJson(json['settings']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (data != null) 'data': data!.toJson(),
      if (settings != null) 'settings': settings!.toJson(),
    };
  }
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) {
    // Add fields here when Data has properties
    return Data();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class Settings {
  final int? success;
  final String? message;
  final int? status;

  Settings({this.success, this.message, this.status});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      success: json['success'] as int?,
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
    };
  }
}
