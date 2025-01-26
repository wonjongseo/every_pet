import 'package:every_pet/controllers/welcome_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:hive/hive.dart';
part 'cat_model.g.dart';

@HiveType(typeId: 5)
class CatModel extends PetModel {
  CatModel({
    required String name,
    required String imageUrl,
    required DateTime birthDay,
    required GENDER_TYPE genderType,
    required int weight,
    bool? isNeuter,
    bool? isPregnancy,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          weight: weight,
          birthDay: birthDay,
          genderType: genderType,
          isNeuter: isNeuter,
          isPregnancy: isPregnancy,
        );

  double getRER() {
    return 0.0;
  }

/**
 
 강아지 몇살부터가 성견이야 ?
 강아지느 몇키로부터 비만이야 ?
 비만인데 중성화한 경우는 DER을 어떻게 구해?
 */
  double getDER() {
    return 0;
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