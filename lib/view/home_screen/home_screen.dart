import 'package:flutter/material.dart';
import 'package:todo_task/controller/todo_controller.dart';
import 'package:todo_task/core/color_constants/color_constants.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/view/home_screen/widgets/custom_todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? selectedDropValue;
TextEditingController titleController = TextEditingController();
var formKey = GlobalKey<FormState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    TodoController.getInitKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "ToDo List",
                style:
                    TextStyle(color: ColorConstants.primaryGreen, fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TodoModel todoModel = TodoController.getTodoData(
                        TodoController.todoListKeys[index])!;
                    return CustomToDo(
                      title: todoModel.title,
                      category: todoModel.category,
                      isCompeted: todoModel.isCompleted,
                      onChanged: (p0) async {
                        todoModel.isCompleted = p0!;
                        await TodoController.updateTodoCompleted(
                            TodoController.todoListKeys[index], todoModel);
                        setState(() {});
                      },
                      onDeletePressed: () async {
                        await TodoController.deleteTodoData(
                            TodoController.todoListKeys[index]);
                        setState(() {});
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: TodoController.todoListKeys.length),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          selectedDropValue = null;
          bottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ColorConstants.primaryWhite,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, bottomSetState) => Container(
          padding: const EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    onTap: () {},
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: ColorConstants.primaryGrey,
                        hintText: "Title",
                        hintStyle:
                            TextStyle(color: ColorConstants.primaryBlack),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConstants.primaryBlack),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title is Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButton(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    value: selectedDropValue,
                    hint: Text("Category"),
                    items: [
                      DropdownMenuItem(
                        child: Text("Personal"),
                        value: "Personal",
                      ),
                      DropdownMenuItem(
                        child: Text("Gym"),
                        value: "Gym",
                      )
                    ],
                    onChanged: (value) {
                      bottomSetState(() {
                        selectedDropValue = value;
                      });
                      print(selectedDropValue);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.primaryWhite),
                        child: Center(
                            child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: ColorConstants.primaryBlack,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      InkWell(
                        onTap: () async {
                          formKey.currentState!.validate();
                          await TodoController.addTodoData(TodoModel(
                              title: titleController.text,
                              category: selectedDropValue!,
                              isCompleted: false));
                          setState(() {});

                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.primaryWhite),
                          child: Center(
                              child: Text(
                            "Add",
                            style: TextStyle(
                                color: ColorConstants.primaryBlack,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
