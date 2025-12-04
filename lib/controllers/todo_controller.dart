import 'dart:collection';

import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/main_controller.dart';
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

/// 캘린더 기반 Todo(스탬프 + 메모)를 관리하는 컨트롤러
class TodoController extends GetxController {
  /// 현재 캘린더에서 포커스된 날짜 (사용자가 선택한 날)
  late DateTime _focusedDay;
  DateTime get focusedDay => _focusedDay;
  set focusedDay(DateTime date) {
    _focusedDay = date;
  }

  /// 스탬프 관리용 컨트롤러
  StampController stampController = Get.put(StampController());

  /// Todo 로컬/원격 저장소
  TodoRepository todoRepository = TodoRepository();

  /// 현재 포커스된 날짜에 해당하는 Todo 리스트를 반환
  List<TodoModel>? get getFocusedDayEvent {
    return kEvents[focusedDay];
  }

  /// 포커스된 날짜에 실제 데이터가 있는지 체크
  /// - 리스트가 null / 비어 있음
  /// - 첫 번째 Todo의 stamps, memo가 모두 비어 있음 ⇒ 의미 있는 데이터 없음
  bool isNotEmptyFocusedDayEvent() {
    if (getFocusedDayEvent == null) {
      return false;
    } else if (getFocusedDayEvent!.isEmpty) {
      return false;
    } else if (getFocusedDayEvent![0].stamps.isEmpty &&
        getFocusedDayEvent![0].memo.isEmpty) {
      return false;
    }

    return true;
  }

  /// 날짜(DateTime)를 키로 사용하는 이벤트 맵
  /// - equals: 같은 날인지 비교할 때 isSameDay 사용
  /// - hashCode: 커스텀 getHashCode 사용
  final kEvents = LinkedHashMap<DateTime, List<TodoModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  /// 현재 선택된 펫 정보 컨트롤러
  late PetsController petsController = Get.find<PetsController>();

  /// 컨트롤러 초기화 시 전체 Todo 로드
  @override
  void onInit() async {
    super.onInit();

    getAllTodos();
  }

  /// 저장소에서 모든 Todo를 불러온 뒤,
  /// 현재 선택된 펫 기준으로 화면용 데이터 구성
  Future<void> getAllTodos() async {
    _todoModels = await todoRepository.getTodos();
    getTodos(petsController.pet);
  }

  /// 전체 TodoModel 캐시
  List<TodoModel> _todoModels = [];

  /// 지정된 펫의 Todo만 필터링하여 kEvents에 매핑
  void getTodos(PetModel pet) async {
    // 현재 펫에 해당하는 Todo만 필터링
    List<TodoModel> tempTodoModel =
        _todoModels.where((element) => element.petModel == pet).toList();

    // 기존 이벤트 초기화
    kEvents.clear();

    // 날짜별로 Todo를 kEvents에 모아 넣기
    for (var todoModel in tempTodoModel) {
      if (kEvents[todoModel.dateTime] == null) {
        kEvents[todoModel.dateTime] = [];
      }
      kEvents[todoModel.dateTime]!.add(todoModel);
    }
    update();

    // 더미 Todo(스탬프/메모 모두 비어있는 것) 정리
    for (var todoModel in tempTodoModel) {
      if (todoModel.stamps.isEmpty && todoModel.memo.isEmpty) {
        todoRepository.deleteTodo(todoModel);
      }
    }
  }

  /// 캘린더에서 날짜 선택 시 호출
  /// - 해당 날짜로 포커스 이동
  /// - 데이터가 없으면 바로 추가 다이얼로그
  /// - 데이터가 있으면 BottomSheet 열기
  void onDaySelected(
    BuildContext context,
    DateTime focusedDay,
  ) async {
    _focusedDay = focusedDay;
    update();

    // 선택한 날짜에 의미 있는 데이터가 없으면 바로 추가 다이얼로그
    if (!isNotEmptyFocusedDayEvent()) {
      clickAddbtn();
      return;
    }

    // 데이터가 있으면 BottomSheet로 상세 표시
    MainController.to.bottomSheetController = showBottomSheet(
      context: context,
      builder: (context) {
        return const BottomSheetWidget();
      },
    );
  }

  /// 포커스된 날짜에 저장된 스탬프 리스트 반환
  /// (없으면 빈 리스트)
  List<StampModel> getSavedStampIndex() {
    if (kEvents[focusedDay] == null) {
      return [];
    }

    List<StampModel> savedStampIndex = kEvents[focusedDay]![0].stamps;

    return savedStampIndex;
  }

  /// 주어진 날짜에 index에 해당하는 스탬프가 저장되어 있는지 확인
  /// (※ 매개변수 타입/이름은 기존 코드 유지)
  bool isSaved(DataTable focusedDay, int index) {
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

  /// + 버튼 클릭 시 Todo 추가/수정 다이얼로그 표시
  /// - 이미 해당 날짜에 메모가 있으면 기본값으로 전달
  /// - 결과를 받아 Todo 추가/수정/삭제 처리
  /// - 필요 시 전면 광고 노출
  void clickAddbtn() async {
    bool showAd = true;
    String? savedMemo;

    // 해당 날짜에 기존 메모가 있으면 가져오기 (첫 번째 Todo 기준)
    if (getFocusedDayEvent != null) {
      savedMemo = getFocusedDayEvent![0].memo;
    }

    // Todo 추가/수정용 다이얼로그 표시
    final result = await Get.dialog(
      name: "AddTodoDialog",
      GestureDetector(
        // 다이얼로그 외부 탭 시 키보드 내려가기
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

    // 사용자가 취소한 경우
    if (result == null) {
      return;
    }

    // 필수 키가 없으면 무시
    if (!(result as Map<String, dynamic>).containsKey('selectedStamps') ||
        !(result).containsKey('memo') ||
        !(result).containsKey('selectedProfileIndexs')) {
      return;
    }

    // 메모 앞뒤 공백 제거
    String memo = result['memo'];
    memo = memo.trim();

    // 선택된 스탬프, 프로필 인덱스(펫 인덱스) 추출
    List<StampModel> selectedStamps =
        result['selectedStamps'] as List<StampModel>;

    List<int> selectedProfileIndexs =
        result['selectedProfileIndexs'] as List<int>;

    // 해당 날짜에 Todo 리스트가 없으면 초기화
    if (kEvents[focusedDay] == null) {
      kEvents[focusedDay] = [];
    }

    // 선택된 각 펫에 대해 Todo 생성/갱신
    for (var selectedPetIndex in selectedProfileIndexs) {
      TodoModel newTodoModel = TodoModel(
        stamps: selectedStamps,
        memo: memo,
        dateTime: focusedDay,
        petModel: petsController.getPetOfIndex(selectedPetIndex),
      );

      TodoModel? savedTodoModel;

      // 동일한 Todo가 이미 있는지 _todoModels에서 검색
      for (var tempTodoModel in _todoModels) {
        if (tempTodoModel == newTodoModel) {
          savedTodoModel = tempTodoModel;
          break;
        }
      }

      if (savedTodoModel == null) {
        // 저장된 Todo가 없으면 새로 추가
        addTodos(newTodoModel);
      } else {
        // 스탬프와 메모가 모두 비어 있으면 Todo 삭제
        if (newTodoModel.stamps.isEmpty && memo.isEmpty) {
          kEvents[focusedDay] = [];
          showAd = false; // 삭제일 경우 광고 미표시
          await deleteTodo(savedTodoModel);
        } else {
          // 기존 Todo를 새 데이터로 갱신
          updateTodo(savedTodoModel, newTodoModel);
        }
      }
    }

    // 광고를 보여야 하는 경우만 전면 광고 시도
    if (showAd) {
      await InterstitialManager.instance.maybeShow();
    }

    // 전체 Todo를 다시 로딩하여 화면 갱신
    getTodos(petsController.pet);
  }

  /// 등록된 스탬프 이름을 변경하거나 삭제할 때
  /// 현재 스탬프 리스트에 해당 이름이 존재하는지 확인
  /// (true면 아직 사용 중인 스탬프)
  bool checkStamp(String name) {
    for (var stamp in stampController.stamps) {
      if (stamp.name == name) {
        return true;
      }
    }
    return false;
  }

  /// 포커스된 날짜의 스탬프를 하나 제거
  /// - index 위치의 스탬프 삭제 후 저장소에 반영
  void subtractStamp(int index) {
    if (getFocusedDayEvent == null) return;

    getFocusedDayEvent![0].stamps.removeAt(index);
    update();
    todoRepository.saveTodo(getFocusedDayEvent![0]);
    getAllTodos();
  }

  /// 특정 펫과 관련된 Todo를 전부 삭제
  Future<void> deleteTodoByPet(PetModel petModel) async {
    // 순회 중 리스트 변경 방지를 위해 복사본 사용
    List tempTodoList = List.from(_todoModels);
    for (var todo in tempTodoList) {
      if (todo.petModel == petModel) {
        await deleteTodo(todo);
      }
    }
  }

  /// 새로운 Todo 추가
  void addTodos(TodoModel newTodoModel) {
    _todoModels.add(newTodoModel); // 저장되어 있는 Todo가 없으면, 신규 등록
    todoRepository.saveTodo(newTodoModel);
  }

  /// 기존 Todo를 새 Todo로 교체 후 저장
  void updateTodo(TodoModel savedTodoModel, TodoModel newTodoModel) {
    _todoModels.remove(savedTodoModel);
    _todoModels.add(newTodoModel);
    todoRepository.saveTodo(newTodoModel);
  }

  /// Todo 삭제
  Future<void> deleteTodo(TodoModel savedTodoModel) async {
    await todoRepository.deleteTodo(savedTodoModel);
    _todoModels.remove(savedTodoModel);
  }

  /// table_calendar에서 사용하는, 특정 날의 이벤트 목록 반환
  List<TodoModel> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
}
