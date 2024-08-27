import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_c11_mon/core/firebase_utlis.dart';
import 'package:todo_app_c11_mon/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.white),
        child: ListTile(
          leading: Container(
            width: 6,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: theme.primaryColor,
            ),
            child: Slidable(
              startActionPane: ActionPane(
                motion: const BehindMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    padding: EdgeInsets.zero,
                    onPressed: (context) {
                      EasyLoading.show();
                      FirebaseUtils.deleteTask(taskModel)
                          .then((value) => EasyLoading.dismiss());
                    },
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: ListTile(
                  leading: Container(
                    width: 6,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: taskModel.isDone
                          ? const Color(0xFF61E757)
                          : theme.primaryColor,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        taskModel.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: taskModel.isDone
                              ? const Color(0xFF61E757)
                              : theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        taskModel.description,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            size: 16,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat("dd MMM,yy ")
                                .format(taskModel.selectionDate),
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  trailing: taskModel.isDone
                      ? Text(
                          "Done",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF61E757),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            EasyLoading.show();
                            FirebaseUtils.updateTask(taskModel)
                                .then((value) => EasyLoading.dismiss());
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: theme.primaryColor,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ));
  }
}
