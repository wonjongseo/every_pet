import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoSmallCricle extends StatelessWidget {
  const TodoSmallCricle({
    super.key,
    required this.focusedDay,
  });
  final TodoModel focusedDay;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width10 * 2.5,
      height: Responsive.width10 * 2.5,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: focusedDay.stamps.length > 4 ? 4 : focusedDay.stamps.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: focusedDay.stamps[index].getColor(),
            ),
          );
        },
      ),
    );
  }
}
