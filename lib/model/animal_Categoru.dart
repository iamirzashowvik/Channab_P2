// To parse this JSON data, do
//
//     final animalCategory = animalCategoryFromJson(jsonString);

import 'dart:convert';

AnimalCategory animalCategoryFromJson(String str) =>
    AnimalCategory.fromJson(json.decode(str));

String animalCategoryToJson(AnimalCategory data) => json.encode(data.toJson());

class AnimalCategory {
  AnimalCategory({
    this.message,
    this.status,
    this.allCategories,
  });

  String message;
  int status;
  List<AllCategory> allCategories;

  factory AnimalCategory.fromJson(Map<String, dynamic> json) => AnimalCategory(
        message: json["message"],
        status: json["status"],
        allCategories: List<AllCategory>.from(
            json["all_categories"].map((x) => AllCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "all_categories":
            List<dynamic>.from(allCategories.map((x) => x.toJson())),
      };
}

class AllCategory {
  AllCategory({
    this.nameOfCategory,
    this.id,
  });

  String nameOfCategory;
  int id;

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
        nameOfCategory: json["name_of_category"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name_of_category": nameOfCategory,
        "id": id,
      };
}
