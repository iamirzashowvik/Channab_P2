// To parse this JSON data, do
//
//     final animallistModel = animallistModelFromJson(jsonString);

import 'dart:convert';

AnimallistModel animallistModelFromJson(String str) =>
    AnimallistModel.fromJson(json.decode(str));

String animallistModelToJson(AnimallistModel data) =>
    json.encode(data.toJson());

class AnimallistModel {
  AnimallistModel({
    this.allAnimalList,
    this.status,
  });

  List<AllAnimalList> allAnimalList;
  int status;

  factory AnimallistModel.fromJson(Map<String, dynamic> json) =>
      AnimallistModel(
        allAnimalList: List<AllAnimalList>.from(
            json["all_animal_list"].map((x) => AllAnimalList.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "all_animal_list":
            List<dynamic>.from(allAnimalList.map((x) => x.toJson())),
        "status": status,
      };
}

class AllAnimalList {
  AllAnimalList({
    this.id,
    this.animalTag,
    this.gender,
    this.image,
    this.status,
    this.animalType,
    this.animalBreed,
  });

  int id;
  String animalTag;
  String gender;
  String image;
  bool status;
  String animalType;
  String animalBreed;

  factory AllAnimalList.fromJson(Map<String, dynamic> json) => AllAnimalList(
        id: json["id"],
        animalTag: json["animal_tag"],
        gender: json["gender"],
        image: json["image"],
        status: json["status"],
        animalType: json["animal_type"],
        animalBreed: json["animal_breed"] == null ? null : json["animal_breed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "animal_tag": animalTag,
        "gender": gender,
        "image": image,
        "status": status,
        "animal_type": animalType,
        "animal_breed": animalBreed == null ? null : animalBreed,
      };
}
