class CategoryModel {
  List<CategoriesList>? category;
  Settings? settings;

  CategoryModel({this.category, this.settings});

  // Change from Map<String, dynamic> to handle List<dynamic> for the 'data' field
  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      category = <CategoriesList>[];  // Initialize the list of categories
      json['data'].forEach((v) {
        category!.add(CategoriesList.fromJson(v)); // Add each category to the list
      });
    }
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (category != null) {
      data['data'] = category!.map((v) => v.toJson()).toList();
    }
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class CategoriesList {
  String? id;
  String? categoryName;
  String? image;

  CategoriesList({this.id, this.categoryName, this.image});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
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
