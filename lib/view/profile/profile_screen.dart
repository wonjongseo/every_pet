import 'dart:developer';
import 'dart:io';

import 'package:every_pet/background2.dart';
import 'package:every_pet/common/native_caller.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/enroll/widgets/gender_selector.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.pet});
  final PetModel pet;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController birthDayEditingController;
  late TextEditingController weightEditingController;
  late TextEditingController hospitalNameEditingController;
  late TextEditingController hospitalNumberEditingController;
  late TextEditingController groomingNameEditingController;
  late TextEditingController groomingNumberEditingController;

  GENDER_TYPE genderType = GENDER_TYPE.MALE;
  DateTime? birthDay;
  PetsController petController = Get.find<PetsController>();
  bool isNeuter = false; // 중성화
  String imagePath = AppImagePath.bisyon;
  bool isPregnancy = false;
  PET_TYPE petType = PET_TYPE.DOG;

  bool isSavedImage = true;

  void togglePregnancy(bool? value) {
    if (value == null) return;

    isPregnancy = value;
    setState(() {});
  }

  void toggleNeuter(bool? value) {
    if (value == null) return;

    setState(() {
      isNeuter = value;
    });
  }

  void toogleRadio(PET_TYPE? value) {
    if (value == null) return;
    petType = value;

    if (petType == PET_TYPE.DOG) {
      imagePath = AppImagePath.bisyon;
    } else {
      imagePath = AppImagePath.defaultCat;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPetInfo(widget.pet);
  }

  void aa() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();
  }

  loadPetInfo(PetModel pet) async {
    nameEditingController = TextEditingController(
      text: pet.name,
    );
    birthDayEditingController = TextEditingController(
      text: AppFunction.getDayYYYYMMDD(pet.birthDay),
    );
    weightEditingController = TextEditingController(
      text: pet.weight.toString(),
    );
    hospitalNameEditingController = TextEditingController(
      text: pet.hospitalName,
    );

    hospitalNumberEditingController = TextEditingController(
      text: pet.hospitalNumber,
    );

    groomingNameEditingController = TextEditingController(
      text: pet.groomingName,
    );

    groomingNumberEditingController = TextEditingController(
      text: pet.groomingNumber,
    );
    genderType = pet.genderType;
    isPregnancy = pet.isPregnancy ?? false;
    isNeuter = pet.isNeuter ?? false;

    if (pet.imageName.contains(AppImagePath.bisyon) ||
        pet.imageName.contains(AppImagePath.defaultCat)) {
      isSavedImage = false;
      imagePath = pet.profilePath;
    } else {
      // imagePath = '${Get.find<ImagePathController>().path}/${pet.imageName}';
      imagePath = pet.profilePath;
    }
    setState(() {});
  }

  void onChangeGendar(GENDER_TYPE? value) {
    if (value == null || value == genderType) {
      return;
    } else {
      isNeuter = false;
      genderType = value;
      setState(() {});
    }
  }

  void selectBirthDayPicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(DateTime.now().year - 20),
      maxTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        birthDay = date;
        birthDayEditingController.text = AppFunction.getDayYYYYMMDD(birthDay!);
        setState(() {});
      },
      currentTime: DateTime.now(),
      locale: Get.locale.toString().contains('ko')
          ? LocaleType.ko
          : Get.locale.toString().contains('ja')
              ? LocaleType.jp
              : LocaleType.en,
    );
  }

  void pickImageFromCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (image == null) return;
      tempFile = File(image.path);
      imagePath = image.path;

      setState(() {});
    } catch (e) {
      AppFunction.showAlertDialog(context: context, message: e.toString());
    }
  }

  String fileName = '';
  File? tempFile;
  void goToImagePickerScreen() async {
    try {
      tempFile = await AppFunction.goToImagePickerScreen();
      imagePath = tempFile!.path;
      setState(() {});
      ();
    } catch (e) {
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noLibaryPermssion.tr);
    }
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  ScrollController scrollController = ScrollController();
  void updatePet(PetModel oldPetModel) async {
    if (nameEditingController.text.isEmpty) {
      petController.scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.nameCtrHintText.tr,
      );
      return;
    }

    if (weightEditingController.text.isEmpty) {
      petController.scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.weightCtrHint.tr,
      );
      return;
    }

    if (birthDayEditingController.text.isEmpty) {
      petController.scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.birthdayCtrHint.tr,
      );
      return;
    }
    String name = nameEditingController.text;
    if (widget.pet.name != name) {
      if (await petController.isSavedName(name)) {
        petController.scrollGoToTop();
        AppFunction.showInvalidTextFieldSnackBar(
            message: '$name${AppString.isExistName.tr}');
        return;
      }
    }

    String imageUrl = widget.pet.imageName;
    String imageName = widget.pet.imageName;

    String newName = "${const Uuid().v4()}.png";

    final directory = await getLibraryDirectory();

    if (isSavedImage && tempFile != null) {
      // Delete
      final directory = await getLibraryDirectory();
      imageUrl = '${directory.path}/${widget.pet.imageName}';

      File oldFile = File(imageUrl);
      if (await oldFile.exists()) {
        await oldFile.delete();
      }

      imageUrl = '${directory.path}/$newName';
      tempFile!.copy(imageUrl);
      imageName = newName;
    } else if (!isSavedImage && tempFile != null) {
      imageUrl = '${directory.path}/$newName';
      tempFile!.copy(imageUrl);
      imageName = newName;
    }

    PetModel updatedPet = oldPetModel.copyWith(
      name: name,
      imageUrl: imageName,
      birthDay: birthDay ?? oldPetModel.birthDay,
      genderType: genderType,
      weight: double.parse(weightEditingController.text),
      isNeuter: isNeuter,
      isPregnancy: isPregnancy,
      hospitalName: hospitalNameEditingController.text,
      hospitalNumber: hospitalNumberEditingController.text,
      groomingName: groomingNameEditingController.text,
      groomingNumber: groomingNumberEditingController.text,
    );
    petController.updatePetModel(updatedPet);
    AppFunction.showMessageSnackBar(
      title: AppString.completeText.tr,
      message: AppString.updateMsg.tr,
    );
    return;
  }

  void deletePet(String petName) async {
    bool result = await Get.dialog(
        name: "alertBeforedeletingPet",
        AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: FaIcon(FontAwesomeIcons.exclamation),
              ),
              SizedBox(width: Responsive.width10),
              Text(AppString.coutionTr.tr,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: Text(
                  AppString.yesTextTr.tr,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            SizedBox(width: Responsive.width10),
            ElevatedButton(
              onPressed: () => Get.back(result: false),
              child: Text(
                AppString.noTextTr.tr,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
          content: Text.rich(
            TextSpan(
              text: '', // 코마  こま
              style: TextStyle(fontSize: Responsive.width17),
              children: [
                TextSpan(text: AppString.previousDeletePetMsg1Tr.tr),
                TextSpan(
                  text: petName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: Responsive.width18,
                  ),
                ),
                TextSpan(text: '${AppString.previousDeletePetMsg2Tr.tr}\n\n'),
                TextSpan(text: AppString.previousDeletePetMsg3Tr.tr),
                TextSpan(
                  text: petName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: Responsive.width18,
                  ),
                ),
                TextSpan(text: AppString.previousDeletePetMsg4Tr.tr),
              ],
            ),
          ),
        ));

    if (result) {
      Get.back();
      petController.deletePet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BackGround2(
        widget: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: petController.scrollController,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Responsive.width10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(AppString.dogTextTr.tr),
                                  value: PET_TYPE.DOG,
                                  groupValue: petType,
                                  onChanged: toogleRadio,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  title: Text(AppString.catTextTr.tr),
                                  value: PET_TYPE.CAT,
                                  groupValue: petType,
                                  onChanged: toogleRadio,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.height16 * 2,
                              horizontal: Responsive.width16,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      ProfileImage(
                                        imagePath: imagePath,
                                        onTap: () {
                                          Get.to(
                                            () => FullProfileImageScreen(
                                                imagePath: imagePath),
                                          );
                                        },
                                      ),
                                      ImagePickIconRow(
                                        onClickCamaraIcon: () =>
                                            pickImageFromCamera(context),
                                        onClickFolderIcon:
                                            goToImagePickerScreen,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Responsive.height10 * 2),
                                  Form(
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          controller: nameEditingController,
                                          textInputAction: TextInputAction.next,
                                          hintText: AppString.nameTextTr.tr,
                                          fontSize: Responsive.width16,
                                        ),
                                        SizedBox(height: Responsive.height14),
                                        CustomTextField(
                                          fontSize: Responsive.width16,
                                          controller: weightEditingController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                            decimal: true,
                                          ),
                                          hintText: AppString.weightTextTr.tr,
                                          sufficIcon: const Text('kg'),
                                        ),
                                        SizedBox(height: Responsive.height14),
                                        CustomTextField(
                                          onTap: () =>
                                              selectBirthDayPicker(context),
                                          fontSize: Responsive.width16,
                                          readOnly: true,
                                          controller: birthDayEditingController,
                                          hintText: AppString.birthDayTextTr.tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: Responsive.height10 * 4),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width10),
                            child: Column(
                              children: [
                                GendarSelector(
                                  genderType: genderType,
                                  onChangeGender: onChangeGendar,
                                ),
                                SizedBox(height: Responsive.height10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      genderType == GENDER_TYPE.MALE
                                          ? AppString.kyoseiTr.tr
                                          : AppString.fuinnTr.tr,
                                      style: TextStyle(
                                        fontSize: Responsive.width16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.25,
                                      child: Checkbox(
                                        value: isNeuter,
                                        onChanged: toggleNeuter,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Responsive.height10),
                                if (genderType == GENDER_TYPE.FEMALE)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.pregentText.tr,
                                        style: TextStyle(
                                          fontSize: Responsive.width16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.25,
                                        child: Checkbox(
                                          value: isPregnancy,
                                          onChanged: togglePregnancy,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Divider(height: Responsive.height10 * 4),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: Responsive.width10 / 2),
                                  Text(
                                    AppString.regularHospital.tr,
                                    style: TextStyle(
                                      fontSize: Responsive.width18,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width10,
                                  vertical: Responsive.height10,
                                ),
                                child: CustomTextField(
                                  hintText: AppString.hasipitalTextTr.tr,
                                  textInputAction: TextInputAction.next,
                                  controller: hospitalNameEditingController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.width10),
                                child: CustomTextField(
                                  controller: hospitalNumberEditingController,
                                  keyboardType: TextInputType.phone,
                                  hintText: AppString.hasipitalNumTextTr.tr,
                                  widget: IconButton(
                                    onPressed: hospitalNumberEditingController
                                            .text.isNotEmpty
                                        ? () {
                                            NativeCaller.callPhone(
                                                hospitalNumberEditingController
                                                    .text);
                                          }
                                        : null,
                                    icon: const Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.height10 * 4),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: Responsive.width10 / 2),
                                  Text(
                                    AppString.regularTrmingShop.tr,
                                    style: TextStyle(
                                      fontSize: Responsive.width18,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width10,
                                  vertical: Responsive.height10,
                                ),
                                child: CustomTextField(
                                  hintText: AppString.regularTrmingShopName.tr,
                                  textInputAction: TextInputAction.next,
                                  controller: groomingNameEditingController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.width10),
                                child: CustomTextField(
                                  controller: groomingNumberEditingController,
                                  keyboardType: TextInputType.phone,
                                  hintText:
                                      AppString.regularTrmingShopNumber.tr,
                                  widget: IconButton(
                                    onPressed: groomingNumberEditingController
                                            .text.isNotEmpty
                                        ? () {
                                            NativeCaller.callPhone(
                                                groomingNumberEditingController
                                                    .text);
                                          }
                                        : null,
                                    icon: const Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.height40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        label: AppString.updateBtnText.tr,
                        onTap: () => updatePet(widget.pet),
                      ),
                      SizedBox(height: Responsive.height15),
                      CustomButton(
                        label: AppString.deleteBtnText.tr,
                        color: AppColors.secondaryColor,
                        onTap: () => deletePet(widget.pet.name),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.height20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    // required this.pet,
    required this.onTap,
    this.height,
    this.color,
  }) : super(key: key);

  final String label;
  final double? height;
  // final PetModel pet;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height ?? Responsive.height10 * 5.2,
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.width20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color ?? AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: Responsive.width18,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
