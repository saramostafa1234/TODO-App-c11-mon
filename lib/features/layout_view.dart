import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/features/settings/setting_view.dart';
import 'package:todo_app_c11_mon/features/tasks/task_view.dart';
import 'package:todo_app_c11_mon/features/tasks/widget/add_task_bottom_sheet_widhet.dart';

import '../core/widget/setting_prov.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> screens = [
    TaskView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      //show behind color
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: provider.isDark() ? Color(0xff141922) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskBottomSheetWidget());
        },
        child: CircleAvatar(
            radius: 25,
            backgroundColor: theme.primaryColorLight,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 105,
        color: provider.isDark() ? Color(0xff141922) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "Tasks",
                icon: ImageIcon(
                    AssetImage("assets/icons/Icon awesome-list.png"))),
            BottomNavigationBarItem(
                label: "settings",
                icon: ImageIcon(AssetImage("assets/icons/settings_icn.png"))),
          ],
        ),
      ),
    );
  }
}
