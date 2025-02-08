import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:hive/hive.dart';
part 'cat_model.g.dart';

@HiveType(typeId: AppConstant.catModelHiveId)
class CatModel extends PetModel {
  CatModel({
    required String name,
    required String imageUrl,
    required DateTime birthDay,
    required GENDER_TYPE genderType,
    required double weight,
    bool? isNeuter,
    NutritionModel? nutritionModel,
    bool? isPregnancy,
    String? hospitalName,
    String? hospitalNumber,
    String? groomingName,
    String? groomingNumber,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          weight: weight,
          birthDay: birthDay,
          genderType: genderType,
          isNeuter: isNeuter,
          nutritionModel: nutritionModel,
          isPregnancy: isPregnancy,
          hospitalName: hospitalName,
          hospitalNumber: hospitalNumber,
          groomingName: groomingName,
          groomingNumber: groomingNumber,
        );

  @override
  CatModel copyWith({
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
    CatModel pet = CatModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
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

  @override
  double getRER() {
    return 30 * weight + 70;
  }

  bool get isKitten => ageInMonths < 12;

  double get kFactor {
    if (isPregnancy == true) return 4.0; // 임신 중
    if (isKitten) return 2.5; // 고양이 성장기
    if (isNeuter == true) return 1.2; // 중성화 여부
    return 1.4;
  }

  @override
  double getDER() {
    double der = getRER();

    return der * kFactor;
  }
}



/**
 성견 (중성화된 강아지):
DER=RER×1.6

성견 (중성화되지 않은 강아지):
DER=RER×1.8

성견 (과체중인 강아지 - 체중 감량 필요):
DER=RER×1.0

성견 (저체중인 강아지 - 체중 증량 필요):
DER=RER×1.2 1.4


성장 중인 강아지 (4개월 미만):
DER=RER×3.0

성장 중인 강아지 (4개월 이상):
DER=RER×2.0

임신 중인 강아지 (마지막 3분기):
DER=RER×3.0

수유 중인 강아지 (새끼 수에 따라):

DER=RER×(2.0 8.0)
새끼가 많을수록 더 높은 계수를 곱합니다.

작업견 (운동량이 많은 강아지):
DER=RER×(2.0 5.0)
 */