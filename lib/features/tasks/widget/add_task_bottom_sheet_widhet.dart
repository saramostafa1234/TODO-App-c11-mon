import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/core/firebase_utlis.dart';
import 'package:todo_app_c11_mon/core/services/snack_bar_service.dart';
import 'package:todo_app_c11_mon/model/task_model.dart';

import '../../../core/widget/setting_prov.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  @override
  State<AddTaskBottomSheetWidget> createState() =>
      _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 30,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add New Task",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 18)),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: titleController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: provider.isDark() ? Colors.black : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Task Title",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "please enter task title";
                  }
                  return null;
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: descriptionController,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter Task Description",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "please enter task description";
                  }
                  return null;
                }),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Time",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                getSelectedDate();
              },
              child: Text(
                //selectedDate.toString(),
                DateFormat(" dd MMM yyyy").format(selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                print(titleController);
                if (formKey.currentState!.validate()) {
                  var taskModel = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    selectionDate: selectedDate,
                  );
                  print(taskModel.toFireStore());
                  EasyLoading.show();
                  FirebaseUtils.addTaskToFireStore(taskModel).then((value) {
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMessage(
                        "Task Successfully added!");
                  });
                }
              },
              style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColorLight,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              child: Text(
                "save",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSelectedDate() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}
