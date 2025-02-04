// import 'package:every_pet/common/theme/theme.dart';
// import 'package:every_pet/common/widgets/custom_input_field.dart';
// import 'package:every_pet/controllers/todo_controller.dart';
// import 'package:every_pet/models/stamp_model.dart';
// import 'package:every_pet/respository/stamp_repository.dart';
// import 'package:every_pet/view/todo/todo_screen2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class AddTaskView extends StatefulWidget {
//   const AddTaskView({super.key});

//   @override
//   State<AddTaskView> createState() => _AddTaskViewState();
// }

// class _AddTaskViewState extends State<AddTaskView> {
//   List<StampModel> stamps = [];
//   StampRepository stampRepository = StampRepository();

//   TodoController2 _taskController = Get.put(TodoController2());
//   final TextEditingController _titleContoller = TextEditingController();
//   final TextEditingController _noteContoller = TextEditingController();

//   DateTime _selectedDate = DateTime.now();
//   String _endTime = '9:30 pm';
//   String _startTime = DateFormat("hh:mm a").format(DateTime.now());

//   int _selectedRemind = 5;
//   List<int> remindList = [5, 10, 15, 20];

//   String _selectedRepeat = "None";
//   List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

//   int _selectedColor = 0;

//   List<int> _selectedStampsIndex = [];
//   @override
//   void initState() {
//     super.initState();
//     getStamps();
//   }

//   getStamps() async {
//     stamps = await stampRepository.getStamps();
//     print('stamps : ${stamps}');
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: context.theme.backgroundColor,
//       appBar: _appBar(context),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Add  Task',
//                   style: headingStyle,
//                 ),
//                 SizedBox(height: 25),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Stamp',
//                       style: titleStyle,
//                     ),
//                     SizedBox(height: 10),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: List.generate(
//                           stamps.length,
//                           (index) {
//                             return InkWell(
//                               onTap: () {
//                                 if (_selectedStampsIndex.contains(index)) {
//                                   _selectedStampsIndex.remove(index);
//                                 } else {
//                                   _selectedStampsIndex.add(index);
//                                 }
//                                 setState(() {});
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(right: 8),
//                                 height: 60,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                       StampModel.getIcon(index),
//                                     ),
//                                   ),
//                                 ),
//                                 child: _selectedStampsIndex.contains(index)
//                                     ? Icon(Icons.check)
//                                     : null,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 CustomInputField(
//                     controller: _titleContoller,
//                     title: 'Title',
//                     hint: 'Enter your title'),
//                 CustomInputField(
//                     controller: _noteContoller,
//                     title: 'Note',
//                     hint: 'Enter your note'),
//                 CustomInputField(
//                   title: 'Date',
//                   hint: DateFormat.yMd().format(_selectedDate),
//                   widget: IconButton(
//                     onPressed: () {
//                       _getDateFromUser();
//                     },
//                     icon: Icon(
//                       Icons.calendar_today_outlined,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomInputField(
//                         title: 'Start Time',
//                         hint: _startTime,
//                         widget: IconButton(
//                           onPressed: () {
//                             _getTimeFromUser(isStartTime: true);
//                           },
//                           icon: Icon(
//                             Icons.access_time_rounded,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: CustomInputField(
//                         title: 'End Time',
//                         hint: _endTime,
//                         widget: IconButton(
//                           onPressed: () {
//                             _getTimeFromUser(isStartTime: false);
//                           },
//                           icon: Icon(
//                             Icons.access_time_rounded,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 CustomInputField(
//                   title: 'Remind',
//                   hint: "$_selectedRemind minutes early",
//                   widget: DropdownButton(
//                     icon: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.grey,
//                     ),
//                     underline: Container(height: 0),
//                     iconSize: 32,
//                     elevation: 4,
//                     style: subTitleStyle,
//                     items: remindList
//                         .map(
//                           (e) => DropdownMenuItem(
//                             value: e.toString(),
//                             child: Text(e.toString()),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (v) {
//                       _selectedRemind = int.parse(v!);
//                       setState(() {});
//                     },
//                   ),
//                 ),
//                 CustomInputField(
//                   title: 'Repeat',
//                   hint: "$_selectedRepeat",
//                   widget: DropdownButton(
//                     icon: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.grey,
//                     ),
//                     underline: Container(height: 0),
//                     iconSize: 32,
//                     elevation: 4,
//                     style: subTitleStyle,
//                     items: repeatList
//                         .map(
//                           (e) => DropdownMenuItem(
//                             value: e.toString(),
//                             child: Text(
//                               e,
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (v) {
//                       _selectedRepeat = v!;
//                       setState(() {});
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     colorPallete(),
//                     ElevatedButton(
//                         onPressed: () {
//                           _validateDate();
//                         },
//                         child: Text('asasd')),
//                     // CustomButton(label: 'Create Task', onTap: _validateDate)
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _addTaskToDb() async {
//     // int id = await _taskController.addTask(
//     //     task: Task(
//     //   title: _titleContoller.text,
//     //   note: _noteContoller.text,
//     //   date: DateFormat.yMd().format(_selectedDate),
//     //   startTime: _startTime,
//     //   endTime: _endTime,
//     //   remind: _selectedRemind,
//     //   repeat: _selectedRepeat,
//     //   color: _selectedColor,
//     //   isCompleted: 0,
//     // ));

//     // print('id : ${id}');
//   }

//   _validateDate() {
//     if (_titleContoller.text.isNotEmpty && _noteContoller.text.isNotEmpty) {
//       _addTaskToDb();
//       Get.back();
//     } else if (_titleContoller.text.isEmpty || _noteContoller.text.isEmpty) {
//       Get.snackbar(
//         'Required',
//         'All fields are required !',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.white,
//         colorText: pinkClr,
//         icon: Icon(
//           Icons.warning_amber_rounded,
//           color: pinkClr,
//         ),
//       );
//     }
//   }

//   Column colorPallete() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Color',
//           style: titleStyle,
//         ),
//         SizedBox(height: 8),
//         Wrap(
//           children: List.generate(
//             3,
//             (index) => GestureDetector(
//               onTap: () {
//                 _selectedColor = index;
//                 setState(() {});
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: CircleAvatar(
//                   radius: 14,
//                   backgroundColor: index == 0
//                       ? primaryClr
//                       : index == 1
//                           ? pinkClr
//                           : yellowClr,
//                   child: index == _selectedColor
//                       ? Icon(
//                           Icons.done,
//                           color: Colors.white,
//                           size: 16,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   AppBar _appBar(BuildContext context) {
//     return AppBar(
//       // backgroundColor: context.theme.backgroundColor,
//       elevation: 0,
//       leading: GestureDetector(
//         onTap: () => Get.back(),
//         child: Icon(
//           Icons.arrow_back_ios,
//           size: 20,
//         ),
//       ),
//       actions: [
//         CircleAvatar(),
//         SizedBox(width: 20),
//       ],
//     );
//   }

//   _getDateFromUser() async {
//     DateTime? _pickerDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now().subtract(Duration(days: 365 * 3)),
//         lastDate: DateTime.now().add(Duration(days: 365 * 3)));

//     if (_pickerDate != null) {
//       _selectedDate = _pickerDate;
//       setState(() {});
//     } else {
//       print('asasd');
//     }
//   }

//   _getTimeFromUser({required bool isStartTime}) async {
//     TimeOfDay? pickedTime = await _showTimePicker();
//     print('pickedTime : ${pickedTime}');
//     if (pickedTime == null) {
//       print('Time cancled : ${pickedTime}');
//       return;
//     }
//     String _formatedTime = pickedTime.format(context);
//     if (isStartTime) {
//       _startTime = _formatedTime;
//     } else {
//       _endTime = _formatedTime;
//     }
//     setState(() {});
//   }

//   _showTimePicker() {
//     return showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(
//         hour: int.parse(
//           _startTime.split(":")[0],
//         ),
//         minute: int.parse(
//           _startTime.split(":")[1].split(' ')[0],
//         ),
//       ),
//     );
//   }
// }
