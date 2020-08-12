// To parse this JSON data, do
//
//     final animalId = animalIdFromJson(jsonString);

import 'dart:convert';

AnimalId animalIdFromJson(String str) => AnimalId.fromJson(json.decode(str));

String animalIdToJson(AnimalId data) => json.encode(data.toJson());

class AnimalId {
  AnimalId({
    this.status,
    this.currentAnimalBasicDetail,
  });

  int status;
  CurrentAnimalBasicDetail currentAnimalBasicDetail;

  factory AnimalId.fromJson(Map<String, dynamic> json) => AnimalId(
        status: json["status"],
        currentAnimalBasicDetail: CurrentAnimalBasicDetail.fromJson(
            json["current_animal_basic_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "current_animal_basic_detail": currentAnimalBasicDetail.toJson(),
      };
}

class CurrentAnimalBasicDetail {
  CurrentAnimalBasicDetail({
    this.ageInYear,
    this.ageInMonth,
    this.ageInDay,
    this.productId,
    this.animalTag,
    this.animalDateOfBirth,
    this.animalGender,
    this.animalType,
    this.animalBreed,
    this.costPurchase,
    this.dateOfPurchase,
    this.productImage,
  });

  int ageInYear;
  int ageInMonth;
  int ageInDay;
  String productId;
  String animalTag;
  String animalDateOfBirth;
  String animalGender;
  String animalType;
  dynamic animalBreed;
  dynamic costPurchase;
  dynamic dateOfPurchase;
  String productImage;

  factory CurrentAnimalBasicDetail.fromJson(Map<String, dynamic> json) =>
      CurrentAnimalBasicDetail(
        ageInYear: json["age_in_year"],
        ageInMonth: json["age_in_month"],
        ageInDay: json["age_in_day"],
        productId: json["product_id"],
        animalTag: json["animal_tag"],
        animalDateOfBirth: json["animal_date_of_birth"],
        animalGender: json["animal_gender"],
        animalType: json["animal_type"],
        animalBreed: json["animal_breed"],
        costPurchase: json["cost_purchase"],
        dateOfPurchase: json["date_of_purchase"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "age_in_year": ageInYear,
        "age_in_month": ageInMonth,
        "age_in_day": ageInDay,
        "product_id": productId,
        "animal_tag": animalTag,
        "animal_date_of_birth": animalDateOfBirth,
        "animal_gender": animalGender,
        "animal_type": animalType,
        "animal_breed": animalBreed,
        "cost_purchase": costPurchase,
        "date_of_purchase": dateOfPurchase,
        "product_image": productImage,
      };
}
