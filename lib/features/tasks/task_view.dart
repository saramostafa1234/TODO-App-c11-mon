import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/core/firebase_utlis.dart';
import 'package:todo_app_c11_mon/features/tasks/widget/task_item_widget.dart';
import 'package:todo_app_c11_mon/model/task_model.dart';

import '../../core/widget/setting_prov.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var lang = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.22,
                color: theme.primaryColorLight,
                //   padding: EdgeInsets.only(
                //left: 20, right: 20, top: mediaQuery.size.height * 0.06),
                child: Text(
                  lang.toDoList,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color:
                          provider.isDark() ? Color(0xff141922) : Colors.white),
                ),
              ),
              Positioned(
                top: 125,
                width: mediaQuery.size.width,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                        print(_focusDate);
                      });
                    },
                    showTimelineHeader: false,
                    timeLineProps: EasyTimeLineProps(
                      separatorPadding: 15,
                    ),
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? Color(0xFF141922)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: theme.primaryColorLight,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColorLight,
                          fontSize: 14,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: theme.primaryColorLight,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? Color(0xFF141922)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()
                                ? Colors.white
                                : Colors.black),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()
                                ? Colors.white
                                : Colors.black),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()
                                ? Colors.white
                                : Colors.black),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<TaskModel>>(
            stream: FirebaseUtils.getOnTimeReadFromFireStore(_focusDate),
            builder: (context, snapShot) {
              if (snapShot.hasError) {
                return Text("somthing went worng");
              }
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
              var tasksList = snapShot.data;
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList![index]),
                itemCount: tasksList?.length ?? 0,
              );
            },
          ),
        )
        // Expanded(
        //   child: StreamBuilder<QuerySnapshot<TaskModel>>(
        //     stream: FirebaseUtils.getRealTimeDateFromFirestore(_focusDate),
        //     builder: (context, snapshot) {
        //       print(snapshot.error);
        //       if (snapshot.hasError) {
        //         return Text(
        //           snapshot.error.toString(),
        //         );
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(color: theme.primaryColor),
        //         );
        //       }
        //       List<TaskModel> tasksList =
        //           snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
        //       //return Expanded(
        //       return ListView.builder(
        //         itemBuilder: (context, index) => TaskItemWidget(
        //           taskModel: tasksList![index],
        //         ),
        //         itemCount: tasksList?.length ?? 0,
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
