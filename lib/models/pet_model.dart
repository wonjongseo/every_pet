import 'dart:convert';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/controllers/image_path_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:uuid/uuid.dart';
part 'pet_model.g.dart';

@HiveType(typeId: AppConstant.petModelHiveId)
class PetModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String imageName;

  @HiveField(2)
  DateTime birthDay;

  @HiveField(3)
  GENDER_TYPE genderType;

  @HiveField(4)
  bool? isNeuter;

  @HiveField(5)
  bool? isPregnancy;

  @HiveField(6)
  double weight;

  @HiveField(7)
  late String id;

  @HiveField(8)
  late int createdAt;

  @HiveField(9)
  NutritionModel? nutritionModel;

  @HiveField(10)
  String? hospitalName;

  @HiveField(11)
  String? hospitalNumber;

  @HiveField(12)
  String? groomingName;

  @HiveField(13)
  String? groomingNumber;

  String get profilePath {
    String path = Get.find<ImagePathController>().path;

    if (imageName.contains(AppImagePath.bisyon) ||
        imageName.contains(AppImagePath.defaultCat)) {
      return imageName;
    }
    return '$path/$imageName';
  }

  PetModel({
    required this.name,
    required this.imageName,
    required this.birthDay,
    required this.genderType,
    required this.weight,
    this.isNeuter,
    this.nutritionModel,
    this.isPregnancy,
    this.hospitalName,
    this.hospitalNumber,
    this.groomingName,
    this.groomingNumber,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  double getRER() {
    return 0;
  }

  double getDER() {
    return 0;
  }

  int get ageInMonths {
    DateTime now = DateTime.now();
    int months = (now.year - birthDay.year) * 12 + (now.month - birthDay.month);
    return months > 0 ? months : 0;
  }

  int getAgeYear() {
    DateDuration duration = AgeCalculator.age(birthDay);

    return duration.years;
  }

  int getAgeMonth() {
    DateDuration duration = AgeCalculator.age(birthDay);

    return duration.months;
  }

  PetModel copyWith({
    String? name,
    String? imageUrl,
    DateTime? birthDay,
    GENDER_TYPE? genderType,
    bool? isNeuter,
    bool? isPregnancy,
    NutritionModel? nutritionModel,
    double? weight,
    String? hospitalName,
    String? hospitalNumber,
    String? groomingName,
    String? groomingNumber,
  }) {
    PetModel pet = PetModel(
      name: name ?? this.name,
      imageName: imageUrl ?? this.imageName,
      birthDay: birthDay ?? this.birthDay,
      genderType: genderType ?? this.genderType,
      isNeuter: isNeuter ?? this.isNeuter,
      isPregnancy: isPregnancy ?? this.isPregnancy,
      weight: weight ?? this.weight,
      nutritionModel: nutritionModel ?? this.nutritionModel,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalNumber: hospitalNumber ?? this.hospitalNumber,
      groomingName: groomingName ?? this.groomingName,
      groomingNumber: groomingNumber ?? this.groomingNumber,
    );
    pet.id = id;
    pet.createdAt = createdAt;
    return pet;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'imageUrl': imageName});
    result.addAll({'birthDay': birthDay.millisecondsSinceEpoch});
    result.addAll({'weight': weight});
    result.addAll({'id': id});
    result.addAll(
        {'genderType': genderType == GENDER_TYPE.MALE ? 'male' : 'female'});
    if (isNeuter != null) {
      result.addAll({'isNeuter': isNeuter});
    }
    if (isPregnancy != null) {
      result.addAll({'isPregnancy': isPregnancy});
    }

    return result;
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      name: map['name'] ?? '',
      weight: map['weight'] ?? '',
      imageName: map['imageUrl'] ?? '',
      birthDay: DateTime.fromMillisecondsSinceEpoch(map['birthDay']),
      genderType:
          (map['genderType'] == 'male' ? GENDER_TYPE.MALE : GENDER_TYPE.FEMALE),
      isNeuter: map['isNeuter'],
      isPregnancy: map['isPregnancy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PetModel(id: $id, name: $name, weight: $weight, imageUrl: $imageName, birthDay: $birthDay, genderType: $genderType, isNeuter: $isNeuter, isPregnancy: $isPregnancy,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PetModel &&
        other.name == name &&
        other.imageName == imageName &&
        other.birthDay == birthDay &&
        other.genderType == genderType &&
        other.isNeuter == isNeuter &&
        other.weight == weight &&
        other.id == id &&
        other.nutritionModel == nutritionModel &&
        other.isPregnancy == isPregnancy;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imageName.hashCode ^
        birthDay.hashCode ^
        weight.hashCode ^
        genderType.hashCode ^
        isNeuter.hashCode ^
        nutritionModel.hashCode ^
        id.hashCode ^
        isPregnancy.hashCode;
  }
}
