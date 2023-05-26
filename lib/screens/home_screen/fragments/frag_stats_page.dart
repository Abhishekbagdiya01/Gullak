import 'dart:developer';
import 'dart:ffi';

import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/custom_widget/custom_chip.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../bloc/expense_bloc/expense_bloc_bloc.dart';

class FragStatsScreen extends StatefulWidget {
  const FragStatsScreen({super.key});

  @override
  State<FragStatsScreen> createState() => _FragStatsScreenState();
}

class _FragStatsScreenState extends State<FragStatsScreen> {
  List<ExpenseModel> arrExpense = [];
  List<Map<String, dynamic>> arrMonthWiseBal = [];
  List<Map<String, dynamic>> arrYearWiseBal = [];
  List<Map<String, dynamic>> arrWeekWiseBal = [];
  int flag = 1;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseBlocState>(
        builder: (context, state) {
          if (state is ExpenseBlocLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseBlocLoadedState) {
            arrExpense = state.arrExpense.reversed.toList();
            if (state.arrExpense.isNotEmpty) {
              arrMonthWiseBal.clear();

              arrYearWiseBal.clear();

              arrWeekWiseBal.clear();

              List<String> arrUniqueMonths = [];
              List<String> arrUniqueYears = [];
              List<String> arrUniqueWeek = [];

              for (ExpenseModel expense in arrExpense) {
                var date = DateTime.parse(expense.time!);

                // var eachWeek = currentDay - 7;

                var currentDay = DateTime.now().day.toString().length == 1
                    ? '0${DateTime.now().day}'
                    : DateTime.now().day;
                log("$currentDay");

                var currentMonth = DateTime.now().month.toString().length == 1
                    ? '0${DateTime.now().month}'
                    : DateTime.now().month;
                log("month:$currentMonth");

                var eachDate =
                    "${date.year}-${date.month.toString().length == 1 ? "0${date.month}" : "${date.month}"}-${date.day}";
                print("each date $eachDate");
                for (int i = 0; i < 7; i++) {
                  var weeklyDays =
                      "${DateTime.now().year}-$currentMonth-${int.parse("$currentDay") - i}";

                  print("day ${weeklyDays} ");

                  if (!arrUniqueWeek.contains(weeklyDays)) {
                    arrUniqueWeek.add(weeklyDays.toString());
                  }
                }
                var eachMonth =
                    "${date.year}-${date.month.toString().length == 1 ? "0${date.month}" : "${date.month}"}";

                var eachYear = date.year;

                if (!arrUniqueMonths.contains(eachMonth)) {
                  arrUniqueMonths.add(eachMonth);
                }

                if (!arrUniqueYears.contains(eachYear)) {
                  arrUniqueYears.add(eachYear.toString());
                }
              }

              print("Weekly list $arrUniqueWeek");

              print(arrUniqueMonths);

              print(arrUniqueYears);
              weekWiseData(arrUniqueWeek);
              monthWiseData(arrUniqueMonths);
              yearWiseData(arrUniqueYears);
              return Container(
                padding: EdgeInsets.only(top: 34),
                width: double.infinity,
                color: MyColor.bgBColor,
                child: Column(
                  children: [
                    Text(
                      "Dashboard",
                      style: mTextStyle34(
                          mColor: MyColor.bgWColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomChip(
                          label: "Month",
                          bgColor: flag == 1 ? Colors.cyan : Colors.white,
                          voidCallback: () {
                            flag = 1;
                            print(flag);
                            print("Month");
                            setState(() {});
                          },
                        ),
                        CustomChip(
                          label: "Week",
                          bgColor: flag == 2 ? Colors.cyan : Colors.white,
                          voidCallback: () {
                            flag = 2;
                            print(flag);
                            print("week");
                            setState(() {});
                          },
                        ),
                        CustomChip(
                          label: "Year",
                          bgColor: flag == 3 ? Colors.cyan : Colors.white,
                          voidCallback: () {
                            flag = 3;
                            print(flag);
                            print("year");
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    // SfCartesianChart(
                    //   primaryXAxis: CategoryAxis(),
                    //   series: <ColumnSeries<Map<String, dynamic>, String>>[
                    //     ColumnSeries<Map<String, dynamic>, String>(
                    //         dataSource: arrMonthWiseBal,
                    //         xValueMapper: (Map<String, dynamic> data, _) =>
                    //             data['month'],
                    //         yValueMapper: (Map<String, dynamic> data, _) =>
                    //             data['bal'])
                    //   ],
                    // )

                    syncfusionFlutterChart(flag),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Text("No data found"),
            );
          }
          return Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }

  void monthWiseData(List<String> arrUniqueMonth) {
    for (String eachMonth in arrUniqueMonth) {
      List<ExpenseModel> eachMonthExpense = [];

      for (ExpenseModel expense in arrExpense) {
        if (expense.time!.contains(eachMonth)) {
          eachMonthExpense.add(expense);
        }
      }

      double eachMonthBal = 0.0;

      for (ExpenseModel expense in eachMonthExpense) {
        if (expense.type == 1) {
          eachMonthBal += expense.amt!;
        } else {
          eachMonthBal -= expense.amt!;
        }
      }

      arrMonthWiseBal.add({
        'month': Constants.mapMonth[eachMonth.split("-")[1]],
        'bal': eachMonthBal
      });
    }
    print(arrMonthWiseBal);
  }

  void yearWiseData(List<String> arrUniqueYear) {
    for (String eachYear in arrUniqueYear) {
      List<ExpenseModel> eachYearExpense = [];

      for (ExpenseModel expense in arrExpense) {
        if (expense.time!.contains(eachYear)) {
          eachYearExpense.add(expense);
        }
      }

      double eachYearBal = 0.0;

      for (ExpenseModel expense in eachYearExpense) {
        if (expense.type == 1) {
          eachYearBal += expense.amt!;
        } else {
          eachYearBal -= expense.amt!;
        }
      }

      arrYearWiseBal.add({'year': eachYear, 'bal': eachYearBal});
    }
    print(arrYearWiseBal);
  }

  void weekWiseData(List<String> arrUniqueWeek) {
    for (String eachWeek in arrUniqueWeek) {
      List<ExpenseModel> eachYearExpense = [];

      for (ExpenseModel expense in arrExpense) {
        if (expense.time!.contains(eachWeek)) {
          eachYearExpense.add(expense);
        }
      }

      double eachWeekBal = 0.0;

      for (ExpenseModel expense in eachYearExpense) {
        if (expense.type == 1) {
          eachWeekBal += expense.amt!;
        } else {
          eachWeekBal -= expense.amt!;
        }
      }

      arrWeekWiseBal.add({'week': eachWeek, 'bal': eachWeekBal});
    }
    print(arrWeekWiseBal);
  }

  Widget syncfusionFlutterChart(int flag) {
    if (flag == 1) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ColumnSeries<Map<String, dynamic>, String>>[
          ColumnSeries<Map<String, dynamic>, String>(
              dataSource: arrMonthWiseBal,
              xValueMapper: (Map<String, dynamic> data, _) => data['month'],
              yValueMapper: (Map<String, dynamic> data, _) => data['bal'])
        ],
      );
    } else if (flag == 2) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ColumnSeries<Map<String, dynamic>, String>>[
          ColumnSeries<Map<String, dynamic>, String>(
              dataSource: arrWeekWiseBal,
              xValueMapper: (Map<String, dynamic> data, _) => data['week'],
              yValueMapper: (Map<String, dynamic> data, _) => data['bal'])
        ],
      );
    } else if (flag == 3) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ColumnSeries<Map<String, dynamic>, String>>[
          ColumnSeries<Map<String, dynamic>, String>(
              dataSource: arrYearWiseBal,
              xValueMapper: (Map<String, dynamic> data, _) => data['year'],
              yValueMapper: (Map<String, dynamic> data, _) => data['bal'])
        ],
      );
    }
    return SizedBox();
  }
}
