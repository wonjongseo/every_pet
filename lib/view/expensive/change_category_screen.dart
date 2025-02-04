import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/models/product_category_model.dart';
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
        title: Text("항목 변경", style: headingStyle),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: SafeArea(
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
                          return ListTile(
                            iconColor: AppColors.primaryColor,
                            title: CustomTextField(
                              readOnly: !(selectedIndex == index),
                              focusNode:
                                  selectedIndex == index ? focusNode : null,
                              controller: selectedIndex == index
                                  ? textEditingController
                                  : null,
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
                                if (selectedIndex != index)
                                  IconButton(
                                    onPressed: () {
                                      selectedIndex = index;
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
                                IconButton(
                                  onPressed: () {
                                    categoryController.deleteCategory(
                                        categoryController.categories[index]);
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.deleteLeft),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: .3);
                        },
                        itemCount: categoryController.categories.length -
                            2), // categories의 마지막에 +, -  가 들어가 있기 때문에 -2
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
