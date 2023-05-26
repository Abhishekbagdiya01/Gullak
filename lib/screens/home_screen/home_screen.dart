import 'package:expense_tracker/screens/add_expense_screen/add_expense_page.dart';
import 'package:expense_tracker/screens/home_screen/fragments/frag_stats_page.dart';
import 'package:expense_tracker/screens/home_screen/fragments/transaction_screen.dart';
import 'package:expense_tracker/ui_helper.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List arrItems = [
    TransactionScreen(),
    FragStatsScreen(),
  ];

  var crntIndex = 0;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Container(
        child: arrItems[crntIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              isLight ? MyColor.secondaryBColor : MyColor.secondaryWColor,
          currentIndex: crntIndex,
          selectedIconTheme: IconThemeData(
              color: isLight ? MyColor.bgWColor : MyColor.bgBColor),
          // unselectedIconTheme: IconThemeData(color: MyColor.secondaryWColor),
          onTap: (value) {
            crntIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.inbox_outlined,
                color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
              ),
              label: "",
              tooltip: "Transactions",
              activeIcon: Icon(
                Icons.inbox_rounded,
                color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.stacked_bar_chart_outlined,
                  color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                ),
                label: "",
                tooltip: "Stats",
                activeIcon: Icon(
                  Icons.stacked_bar_chart_rounded,
                  color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                ))
          ]),
    );
  }
}
