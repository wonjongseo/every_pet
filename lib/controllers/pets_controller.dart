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

class PetsController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  PetRepository petRepository = PetRepository();
  ScrollController scrollController = ScrollController();

  final _pets = <PetModel>[];
  List<PetModel> get pets => _pets;
  PetModel get pet => _pets[_petPageIndex.value];

  final _petPageIndex = 0.obs;
  int get petPageIndex => _petPageIndex.value;

  TodoController todoController = Get.find<TodoController>();
  NutritionController nutritionController = Get.find<NutritionController>();

  void changePetIndex(int newIndex) {
    _petPageIndex.value = newIndex;
    update();
  }

  PetModel getPetOfIndex(int index) {
    return _pets[index];
  }

  @override
  void onInit() async {
    super.onInit();

    _petPageIndex.value =
        SettingRepository.getInt(AppConstant.lastPetIndexKey) ?? 0;

    await getPetModals();
  }

  @override
  void onReady() async {
    await _setAppReviewRequest();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future<void> deletePet() async {
    PetModel petModel = _pets[_petPageIndex.value];
    await todoController.deleteTodoByPet(petModel);
    await petRepository.deletePet(petModel);
    await getPetModals();

    if (_pets.isEmpty) {
      Get.offAll(() => const EnrollScreen(isFirst: true));
      return;
    }
    if (_petPageIndex.value != 0) {
      _petPageIndex.value -= 1;
      SettingRepository.setInt(
          AppConstant.lastPetIndexKey, _petPageIndex.value);
    }

    scrollGoToTop();
  }

  void goToEnrollScreen() async {
    MainController.to.closeBottomSheet();

    Get.to(() => EnrollScreen(isFirst: _pets.isEmpty));
  }

  void onTapTopBar(int index) {
    _petPageIndex.value = index;
    todoController.getTodos(_pets[_petPageIndex.value]);

    SettingRepository.setInt(AppConstant.lastPetIndexKey, _petPageIndex.value);
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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

  void updatePetModel(PetModel petModel, {bool isProfileScreen = true}) {
    petRepository.savePet(petModel);
    getPetModals();
    if (isProfileScreen) {
      scrollGoToTop();
    }
  }

  Future<bool> isSavedName(String name) async {
    return await petRepository.isExistPetName(name);
  }

  Future<void> savePetModal(PetModel petModel) async {
    await petRepository.savePet(petModel);
    await getPetModals();
  }

  Future<void> _setAppReviewRequest() async {
    AppReviewController.checkReviewRequest();
  }
}
