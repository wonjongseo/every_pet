import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EditGroceriesScreen extends StatefulWidget {
  const EditGroceriesScreen({super.key});

  @override
  State<EditGroceriesScreen> createState() => _EditGroceriesScreenState();
}

class _EditGroceriesScreenState extends State<EditGroceriesScreen> {
  int selectedIndex = -1;
  FocusNode focusNode = FocusNode();

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController kcalEditingController = TextEditingController();
  TextEditingController gramEditingController = TextEditingController();

  @override
  void dispose() {
    nameEditingController.dispose();
    kcalEditingController.dispose();
    gramEditingController.dispose();
    emptyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalculateKcalController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppString.editMenuText.tr, style: headingStyle),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AddOrRemoveButton(
                    onTap: controller.addNewGrocery,
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
                      SizedBox(height: Responsive.height20),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;
                            return editGroceryListTile(
                              isSelected,
                              controller,
                              index,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(thickness: .3);
                          },
                          itemCount: controller.groceriesModels.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ListTile editGroceryListTile(
      bool isSelected, CalculateKcalController controller, int index) {
    return ListTile(
      isThreeLine: true,
      iconColor: AppColors.primaryColor,
      title: groceryTextField(isSelected, controller, index),
      subtitle: const SizedBox(), // For isThreeLine: true, Don't Delete
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isSelected)
            IconButton(
              onPressed: () => onClickEditBtn(
                index,
                controller,
              ),
              icon: const FaIcon(FontAwesomeIcons.pencil),
            )
          else
            IconButton(
              onPressed: () {
                controller.updateGrocery(index, nameEditingController.text,
                    kcalEditingController.text, gramEditingController.text);
                selectedIndex = -1;
                setState(() {});
              },
              icon: const FaIcon(FontAwesomeIcons.save),
            ),
          AddOrRemoveButton(
            onTap: () => controller.deleteGrocery(
              controller.groceriesModels[index],
            ),
            addOrRemove: AddOrRemoveType.REMOVE,
          )
        ],
      ),
    );
  }

  TextEditingController emptyEditingController = TextEditingController();

  Column groceryTextField(
      bool isSelected, CalculateKcalController controller, int index) {
    return Column(
      children: [
        CustomTextField(
          readOnly: !(isSelected),
          focusNode: isSelected ? focusNode : null,
          controller:
              isSelected ? nameEditingController : emptyEditingController,
          hintText: controller.groceriesModels[index].name,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          readOnly: !(isSelected),
          controller:
              isSelected ? kcalEditingController : emptyEditingController,
          hintText: controller.groceriesModels[index].kcal.toStringAsFixed(1),
          sufficIcon: Text(
            'kcal',
            style: subTitleStyle,
          ),
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          readOnly: !(isSelected),
          controller:
              isSelected ? gramEditingController : emptyEditingController,
          hintText: controller.groceriesModels[index].gram.toString(),
          onFieldSubmitted: (p0) {
            controller.updateGrocery(
              index,
              nameEditingController.text,
              kcalEditingController.text,
              gramEditingController.text,
            );

            selectedIndex = -1;
            setState(() {});
          },
          sufficIcon: Text(
            'gram',
            style: subTitleStyle,
          ),
        )
      ],
    );
  }

  void onClickEditBtn(int index, CalculateKcalController controller) {
    selectedIndex = index;

    nameEditingController.clear();
    kcalEditingController.clear();
    gramEditingController.clear();

    setState(() {});

    selectedIndex = index;
    nameEditingController.text = controller.groceriesModels[selectedIndex].name;
    kcalEditingController.text =
        controller.groceriesModels[selectedIndex].kcal.toStringAsFixed(1);
    gramEditingController.text =
        controller.groceriesModels[selectedIndex].gram.toString();

    focusNode.requestFocus();
    setState(() {});
  }
}
