import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/controllers/app_review_controller.dart';
import 'package:every_pet/controllers/main_controller.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';

import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 펫 리스트 및 현재 선택된 펫을 관리하는 컨트롤러
/// - 펫 추가/수정/삭제
/// - 마지막으로 본 펫 인덱스 저장/복원
/// - 펫 전환 시 Todo, 영양(식단) 관련 컨트롤러와 연동
class PetsController extends GetxController {
  /// 로딩 상태 (펫 목록을 불러오는 중인지 여부)
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// 펫 데이터를 관리하는 레포지토리
  PetRepository petRepository = PetRepository();

  /// 상단 탭/리스트 등 스크롤 제어용 컨트롤러
  ScrollController scrollController = ScrollController();

  /// 앱 내에 등록된 펫 목록
  final _pets = <PetModel>[];
  List<PetModel> get pets => _pets;

  /// 현재 선택된 펫 (petPageIndex 기준)
  PetModel get pet => _pets[_petPageIndex.value];

  /// 현재 선택된 펫 인덱스 (탭/페이지 인덱스)
  final _petPageIndex = 0.obs;
  int get petPageIndex => _petPageIndex.value;

  /// Todo(건강 기록) 관련 컨트롤러
  TodoController todoController = Get.find<TodoController>();

  /// 영양(식단) 관련 컨트롤러
  NutritionController nutritionController = Get.find<NutritionController>();

  /// 펫 인덱스 변경 (UI에서 탭/페이지 이동 시 호출)
  void changePetIndex(int newIndex) {
    _petPageIndex.value = newIndex;
    update();
  }

  /// 주어진 인덱스의 펫 반환
  PetModel getPetOfIndex(int index) {
    return _pets[index];
  }

  /// 컨트롤러 초기화 시
  /// - 마지막으로 선택했던 펫 인덱스를 Setting에서 읽어옴
  /// - 펫 목록 로드
  @override
  void onInit() async {
    super.onInit();

    _petPageIndex.value =
        SettingRepository.getInt(AppConstant.lastPetIndexKey) ?? 0;

    await getPetModals();
  }

  /// 화면에 완전히 마운트된 후 호출
  /// - 앱 리뷰 요청 타이밍 체크
  @override
  void onReady() async {
    await _setAppReviewRequest();
    super.onReady();
  }

  /// 컨트롤러 dispose 시 스크롤 컨트롤러 정리
  @override
  void onClose() {
    scrollController.dispose();
  }

  /// 현재 선택된 펫 삭제
  /// - 해당 펫에 연결된 Todo 전부 삭제
  /// - 펫 데이터 삭제 후 펫 목록 재로딩
  /// - 펫이 하나도 남지 않으면 최초 등록 화면으로 이동
  /// - 남아있는 경우 인덱스 조정 및 스크롤 상단으로 이동
  Future<void> deletePet() async {
    PetModel petModel = _pets[_petPageIndex.value];

    // 해당 펫과 연결된 Todo 전체 삭제
    await todoController.deleteTodoByPet(petModel);

    // 펫 삭제
    await petRepository.deletePet(petModel);

    // 펫 목록 다시 로드
    await getPetModals();

    // 펫이 하나도 없으면 최초 등록 화면으로 이동
    if (_pets.isEmpty) {
      Get.offAll(() => const EnrollScreen(isFirst: true));
      return;
    }

    // 인덱스가 0이 아니라면 하나 줄여서 이전 펫을 선택 상태로
    if (_petPageIndex.value != 0) {
      _petPageIndex.value -= 1;
      SettingRepository.setInt(
        AppConstant.lastPetIndexKey,
        _petPageIndex.value,
      );
    }

    // 상단으로 스크롤
    scrollGoToTop();
  }

  /// 펫 등록/수정 화면으로 이동
  /// - 현재 BottomSheet가 떠 있다면 먼저 닫기
  /// - 첫 펫 등록인지 여부에 따라 isFirst 설정
  void goToEnrollScreen() async {
    MainController.to.closeBottomSheet();

    Get.to(() => EnrollScreen(isFirst: _pets.isEmpty));
  }

  /// 상단 탭(펫 선택 바)을 탭했을 때 호출
  /// - 선택된 인덱스를 변경
  /// - TodoController에 해당 펫의 Todo 재로딩 요청
  /// - 마지막 펫 인덱스를 Setting에 저장
  void onTapTopBar(int index) {
    _petPageIndex.value = index;

    // 선택된 펫의 Todo를 다시 로드
    todoController.getTodos(_pets[_petPageIndex.value]);

    // 마지막으로 선택한 펫 인덱스 저장
    SettingRepository.setInt(AppConstant.lastPetIndexKey, _petPageIndex.value);
  }

  /// 스크롤을 맨 위로 부드럽게 이동
  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 저장소에서 펫 목록을 불러와 _pets에 반영
  /// - 로딩 상태 처리
  /// - 에러 발생 시 스낵바 표시
  Future<void> getPetModals() async {
    try {
      _isLoading.value = true;
      _pets.assignAll(await petRepository.loadPets());
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  /// 펫 정보 업데이트
  /// - 저장 후 펫 목록 다시 로드
  /// - 기본적으로 프로필 화면이면 상단으로 스크롤
  void updatePetModel(
    PetModel petModel, {
    bool isProfileScreen = true,
  }) {
    petRepository.savePet(petModel);
    getPetModals();

    if (isProfileScreen) {
      scrollGoToTop();
    }
  }

  /// 동일한 이름의 펫이 이미 저장되어 있는지 확인
  Future<bool> isSavedName(String name) async {
    return await petRepository.isExistPetName(name);
  }

  /// 새로운 펫 저장 후 목록 재로딩
  Future<void> savePetModal(PetModel petModel) async {
    await petRepository.savePet(petModel);
    await getPetModals();
  }

  /// 앱 리뷰 요청 조건을 체크
  /// (내부에서 적절한 타이밍에 in_app_review를 띄우는 로직)
  Future<void> _setAppReviewRequest() async {
    AppReviewController.checkReviewRequest();
  }
}
