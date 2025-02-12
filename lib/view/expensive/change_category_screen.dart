import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChangeCategoryScreen extends StatefulWidget {
  const ChangeCategoryScreen({super.key});

  @override
  State<ChangeCategoryScreen> createState() => _ChangeCategoryScreenState();
}

class _ChangeCategoryScreenState extends State<ChangeCategoryScreen> {
  int selectedIndex = -1;
  FocusNode focusNode = FocusNode();

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.changeCategoryText.tr, style: headingStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AddOrRemoveButton(
              onTap: categoryController.onTapAddCategoryBtn,
              addOrRemove: AddOrRemoveType.ADD,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: BackGround2(
        widget: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          bool isSelected = selectedIndex == index;
                          return ListTile(
                            iconColor: AppColors.primaryColor,
                            title: CustomTextField(
                              readOnly: !(isSelected),
                              focusNode: isSelected ? focusNode : null,
                              hintStyle: isSelected ? activeHintStyle : null,
                              controller:
                                  isSelected ? textEditingController : null,
                              hintText:
                                  categoryController.categories[index].name,
                              onFieldSubmitted: (p0) {
                                categoryController.updateCategory(index, p0);
                                selectedIndex = -1;
                                setState(() {});
                              },
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!isSelected)
                                  IconButton(
                                    onPressed: () {
                                      textEditingController.dispose;
                                      selectedIndex = index;
                                      textEditingController =
                                          TextEditingController();

                                      textEditingController.text =
                                          categoryController
                                              .categories[selectedIndex].name;

                                      focusNode.requestFocus();
                                      setState(() {});
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.pencil),
                                  )
                                else
                                  IconButton(
                                    onPressed: () {
                                      categoryController.updateCategory(
                                        index,
                                        textEditingController.text,
                                      );
                                      selectedIndex = -1;
                                      setState(() {});
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.save),
                                  ),

                                AddOrRemoveButton(
                                  onTap: () =>
                                      categoryController.deleteCategory(
                                          categoryController.categories[index]),
                                  addOrRemove: AddOrRemoveType.REMOVE,
                                  width: Responsive.width10 * 3.5,
                                )
                                // IconButton(
                                //   onPressed: () {
                                //     categoryController.deleteCategory(
                                //         categoryController.categories[index]);
                                //   },
                                //   icon:
                                //       const FaIcon(FontAwesomeIcons.deleteLeft),
                                // ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: .3);
                        },
                        itemCount: categoryController.categories.length - 1,
                      ), // categories의 마지막에 편집 사인이 들어가 있기 때문에 -1
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
