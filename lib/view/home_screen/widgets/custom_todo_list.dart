import 'package:flutter/material.dart';
import 'package:todo_task/core/color_constants/color_constants.dart';

class CustomToDo extends StatefulWidget {
  CustomToDo(
      {super.key,
      this.onDeletePressed,
      required this.title,
      required this.category});

  bool isChecked = false;
  final String title;
  final String category;
  final void Function()? onDeletePressed;

  @override
  State<CustomToDo> createState() => _CustomToDoState();
}

class _CustomToDoState extends State<CustomToDo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Checkbox(
            value: widget.isChecked,
            onChanged: (value) {
              widget.isChecked = value!;
              setState(() {});
            },
          ),
          Text(
            "${widget.category} - ",
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: widget.isChecked == false
                      ? TextStyle(
                          color: ColorConstants.primaryBlue, fontSize: 20)
                      : TextStyle(
                          color: ColorConstants.primaryBlue,
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: widget.onDeletePressed,
            child: Icon(
              Icons.delete,
              color: ColorConstants.primaryRed,
            ),
          )
        ],
      ),
    );
  }
}
