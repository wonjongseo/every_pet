import 'dart:collection';

import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/respository/todo_repository.dart';
import 'package:every_pet/view/todo/widgets/bottom_sheet_widget.dart';
import 'package:every_pet/view/todo/widgets/add_todo_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoController extends GetxController {
  final kToday = DateTime.now();
  late DateTime kFirstDay, kLastDay;

  StampController stampController = Get.put(StampController());
  DateTime _focusedDay = DateTime.now();

  DateTime get focusedDay => _focusedDay;
  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  TodoRepository todoRepository = TodoRepository();

  List<TodoModel>? getFocusedDayEvent() {
    return kEvents[focusedDay];
  }

  bool isNotEmptyFocusedDayEvent() {
    if (getFocusedDayEvent() == null) {
      return false;
    } else if (getFocusedDayEvent()!.isEmpty) {
      return false;
    } else if (getFocusedDayEvent()![0].stamps.isEmpty &&
        getFocusedDayEvent()![0].memo.isEmpty) {
      return false;
    }

    return true;
  }

  final kEvents = LinkedHashMap<DateTime, List<TodoModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PetsController petsController;
  @override
  void onInit() async {
    super.onInit();
    petsController = Get.find<PetsController>();
    kFirstDay = DateTime(2024);
    kLastDay = DateTime(kToday.year + 2);

    _selectedDay = _focusedDay;

    getAllTodos();
  }

  Future<void> getAllTodos() async {
    if (petsController.hasPets) {
      _todoModels = await todoRepository.getTodos();
      getTodos(petsController.pet!.name);
    }
  }

  List<TodoModel> _todoModels = [];

  List<TodoModel> getTodoByPetName(String petName) {
    return _todoModels
        .where((element) => element.petModel!.name == petName)
        .toList();
  }

  void getTodos(String petName) async {
    List<TodoModel> tempTodoModel = getTodoByPetName(petName);
    kEvents.clear();
    for (var todoModel in tempTodoModel) {
      if (kEvents[todoModel.dateTime] == null) {
        kEvents[todoModel.dateTime] = [];
      }
      kEvents[todoModel.dateTime]!.add(todoModel);
    }
    update();
    // delete dummy todos
    for (var todoModel in tempTodoModel) {
      if (todoModel.stamps.isEmpty && todoModel.memo.isEmpty) {
        todoRepository.deleteTodo(todoModel);
      }
    }
  }

  void onDaySelected(
    BuildContext context,
    DateTime selectedDay,
    DateTime focusedDay,
  ) async {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    update();
    if (!isNotEmptyFocusedDayEvent()) {
      clickAddbtn();
      return;
    }
    petsController.bottomSheetController = showBottomSheet(
      context: context,
      builder: (context) {
        return const BottomSheetWidget();
      },
    );
  }

  List<StampModel> getSavedStampIndex() {
    List<StampModel> savedStampIndex = [];
    if (kEvents[focusedDay] == null) {
      return [];
    }

    for (var stamps in kEvents[focusedDay]![0].stamps) {
      savedStampIndex.add(stamps);
    }

    return savedStampIndex;
  }

  bool isSaved(int index) {
    if (kEvents[focusedDay] == null) {
      return false;
    }

    for (var stamps in kEvents[focusedDay]![0].stamps) {
      if (stamps.iconIndex == index) {
        return true;
      }
    }
    return false;
  }

  void clickAddbtn() async {
    String? savedMemo;

    if (getFocusedDayEvent() != null) {
      savedMemo = getFocusedDayEvent()![0].memo;
    }
    final result = await Get.dialog(
      name: "AddTodoDialog",
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: Responsive.width15),
              content: AddTodoDialog(memo: savedMemo),
            ),
          ),
        ),
      ),
    );

    if (result == null) {
      return;
    }

    if (!(result as Map<String, dynamic>).containsKey('selectedStamps') ||
        !(result).containsKey('memo') ||
        !(result).containsKey('selectedProfileIndexs')) {
      return;
    }
    String memo = result['memo'];
    memo = memo.trim();

    List<StampModel> selectedStamps =
        result['selectedStamps'] as List<StampModel>;

    List<int> selectedProfileIndexs =
        result['selectedProfileIndexs'] as List<int>;

    if (kEvents[focusedDay] == null) {
      kEvents[focusedDay] = [];
    }
    for (var selectedPetIndex in selectedProfileIndexs) {
      TodoModel newTodoModel = TodoModel(
        stamps: selectedStamps,
        memo: memo,
        dateTime: focusedDay,
        petModel: petsController.getPetOfIndex(selectedPetIndex)!,
      );

      TodoModel? savedTodoModel;

      for (var tempTodoModel in _todoModels) {
        if (tempTodoModel == newTodoModel) {
          savedTodoModel = tempTodoModel;
          break;
        }
      }

      if (savedTodoModel == null) {
        addTodos(newTodoModel);
      } else {
        // 既存に保存されていれば、アップデート
        if (newTodoModel.stamps.isEmpty && memo.isEmpty) {
          // Stampもメモもなかったら削除
          kEvents[focusedDay] = [];
          await deleteTodo(savedTodoModel);
        } else {
          updateTodo(savedTodoModel, newTodoModel);
        }
      }
    }
    await InterstitialManager.instance.maybeShow();

    getTodos(petsController.pet!.name);
  }

  // 등록한 스탬프의 이름을 변경할 경우, 삭제 가능
  bool checkStamp(String name) {
    for (var stamp in stampController.stamps) {
      if (stamp.name == name) {
        return true;
      }
    }
    return false;
  }

  void subtractStamp(int index) {
    if (getFocusedDayEvent() == null) return;

    getFocusedDayEvent()![0].stamps.removeAt(index);
    update();
    todoRepository.saveTodo(getFocusedDayEvent()![0]);
    getAllTodos();
  }

  Future<void> deleteTodoByPet(PetModel petModel) async {
    List tempTodoList = List.from(_todoModels);
    for (var todo in tempTodoList) {
      if (todo.petModel! == petModel) {
        await deleteTodo(todo);
      }
    }
  }

  void addTodos(TodoModel newTodoModel) {
    _todoModels.add(newTodoModel); // 保存されているTodoがなければ、新規登録
    todoRepository.saveTodo(newTodoModel);
  }

  void updateTodo(TodoModel savedTodoModel, TodoModel newTodoModel) {
    _todoModels.remove(savedTodoModel);
    _todoModels.add(newTodoModel);
    todoRepository.saveTodo(newTodoModel);
  }

  Future<void> deleteTodo(TodoModel savedTodoModel) async {
    await todoRepository.deleteTodo(savedTodoModel);
    _todoModels.remove(savedTodoModel);
  }

  List<TodoModel> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
}
