import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/controllers/main_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/features/todos/screen/add_detail_todo_screen.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/calculate_kcal/calculate_kcal_screen.dart';
import 'package:every_pet/view/calculate_kcal/edit_groceries_screen.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/expensive/add_expensive_screen.dart';
import 'package:every_pet/view/expensive/change_category_screen.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/splash_screen.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:get/get.dart';

class AppRouter {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: SplashScreen.name,
      page: () => const SplashScreen(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
        name: EnrollScreen.name,
        page: () {
          final isFirst = Get.arguments as bool;
          return EnrollScreen(
            isFirst: isFirst,
          );
        }),
    GetPage(name: MainScreen.name, page: () => const MainScreen(), bindings: [
      BindingsBuilder.put(() => PetsController(), permanent: true),
      BindingsBuilder.put(() => TodoController(), permanent: true),
      BindingsBuilder.put(() => StampController(), permanent: true),
      BindingsBuilder.put(() => NutritionController(), permanent: true),
      BindingsBuilder.put(() => MainController(), permanent: true),
    ]),
    GetPage(
        name: StampCustomScreen.name, page: () => const StampCustomScreen()),
    GetPage(
      name: CalculateKcalScreen.name,
      page: () => const CalculateKcalScreen(),
      binding: BindingsBuilder.put(() => CalculateKcalController()),
    ),
    GetPage(
        name: FullProfileImageScreen.name,
        page: () {
          final imagePath = Get.arguments as String;
          return FullProfileImageScreen(imagePath: imagePath);
        }),
    GetPage(
        name: AddExpensiveScreen.name,
        page: () {
          final selectedDay = Get.arguments as DateTime;
          return AddExpensiveScreen(selectedDay: selectedDay);
        }),
    GetPage(
        name: ProfileScreen.name,
        page: () {
          final pet = Get.arguments as PetModel;
          return ProfileScreen(pet: pet);
        }),
    GetPage(
      name: EditGroceriesScreen.name,
      page: () => const EditGroceriesScreen(),
      binding: BindingsBuilder.put(() => CalculateKcalController()),
    ),
    GetPage(
      name: ChangeCategoryScreen.name,
      page: () => const ChangeCategoryScreen(),
      binding: BindingsBuilder.put(() => CategoryController()),
    ),
    GetPage(
        name: EditDetailTodoScreen.name,
        page: () => const EditDetailTodoScreen())
  ];
}
