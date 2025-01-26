import 'dart:convert';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:every_pet/controllers/welcome_controller.dart';

part 'pet_model.g.dart';

@HiveType(typeId: 0) // typeId는 각 클래스마다 고유해야 함
class PetModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String imageUrl;

  @HiveField(2)
  final DateTime birthDay;

  @HiveField(3)
  final GENDER_TYPE genderType;

  @HiveField(4)
  bool? isNeuter;

  @HiveField(5)
  bool? isPregnancy;

  @HiveField(6)
  double weight;

  @HiveField(7)
  final List<TodoModel> todoModel = [];

  double getRER() {
    return 0;
  }

  double getDER() {
    return 0;
  }

  PetModel({
    required this.name,
    required this.imageUrl,
    required this.birthDay,
    required this.genderType,
    required this.weight,
    this.isNeuter,
    this.isPregnancy,
  });

  PetModel copyWith({
    String? name,
    String? imageUrl,
    DateTime? birthDay,
    GENDER_TYPE? genderType,
    bool? isNeuter,
    bool? isPregnancy,
    double? weight,
  }) {
    return PetModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      birthDay: birthDay ?? this.birthDay,
      genderType: genderType ?? this.genderType,
      isNeuter: isNeuter ?? this.isNeuter,
      isPregnancy: isPregnancy ?? this.isPregnancy,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'birthDay': birthDay.millisecondsSinceEpoch});
    result.addAll({'weight': weight});
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
      imageUrl: map['imageUrl'] ?? '',
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
    return 'PetModel(name: $name, weight: $weight, imageUrl: $imageUrl, birthDay: $birthDay, genderType: $genderType, isNeuter: $isNeuter, isPregnancy: $isPregnancy, todoModel: $todoModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PetModel &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.birthDay == birthDay &&
        other.genderType == genderType &&
        other.isNeuter == isNeuter &&
        other.weight == weight &&
        other.isPregnancy == isPregnancy;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imageUrl.hashCode ^
        birthDay.hashCode ^
        weight.hashCode ^
        genderType.hashCode ^
        isNeuter.hashCode ^
        isPregnancy.hashCode;
  }
}
