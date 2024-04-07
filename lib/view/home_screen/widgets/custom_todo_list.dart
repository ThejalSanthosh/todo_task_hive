import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_task/core/color_constants/color_constants.dart';

class CustomToDo extends StatefulWidget {
  CustomToDo(
      {super.key,
      this.onDeletePressed,
      required this.title,
      required this.category,this.onChanged, required this.isCompeted});

  final String title;
  final String category;
  final bool isCompeted;
  final void Function()? onDeletePressed;
  final void Function(bool?)? onChanged;

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
            value: widget.isCompeted,
            onChanged: widget.onChanged,
          ),

          Expanded(
            child: RichText(
              text: TextSpan(
                text: "${widget.category} - ",
                style: widget.isCompeted == false
                    ? TextStyle(
                        color: ColorConstants.primaryBlack, fontSize: 20)
                    : TextStyle(
                        color: ColorConstants.primaryBlack,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough),
                children: [
                  TextSpan(
                      text: widget.title,
                      style: TextStyle(color: ColorConstants.primaryBlue)),
                ],
              ),
            ),
          ),
       
          Spacer(),
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
