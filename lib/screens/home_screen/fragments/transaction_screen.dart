import 'dart:developer';

import 'package:expense_tracker/models/category_model.dart';
import 'package:expense_tracker/models/day_wise_expense_model.dart';
import 'package:expense_tracker/screens/add_expense_screen/add_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cat_bloc/bloc/expense_type_bloc.dart';
import '../../../bloc/expense_bloc/expense_bloc_bloc.dart';
import '../../../constants.dart';
import '../../../models/expense_model.dart';
import '../../../ui_helper.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  double? width;

  List<ExpenseModel> arrExpenses = [];
  List<CategoryModel> arrExpenseType = [];
  List<DayWiseExpenseModel> arrDayWiseExpense = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseBloc>(context).add(FetchAllExpensesEvent());

    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchExpenseType());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: addTransactionUI(context, widget)),
            Expanded(
              flex: 19,
              child: BlocBuilder<ExpenseBloc, ExpenseBlocState>(
                builder: (_, state) {
                  if (state is ExpenseBlocLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ExpenseBlocLoadedState) {
                    arrExpenses = state.arrExpense.reversed.toList();
                    return state.arrExpense.isNotEmpty
                        ? MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? portraitUI(context, widget)
                            : landscapeUI(context, widget)
                        : Center(
                            child: Text(
                              'No Expense Yet!',
                              style: mTextStyle25(),
                            ),
                          );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget landscapeUI(BuildContext context, widget) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 1, child: addTransactionUI(context, widget)),
              Expanded(flex: 7, child: totalBalanceUI()),
            ],
          ),
        ),
        Expanded(child: BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
          builder: (context, state) {
            if (state is ExpenseTypeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ExpenseTypeLoadedState) {
              arrExpenseType = state.arrExpenseType;
              return transactionListUI();
            }
            return Container();
          },
        ))
      ],
    );
  }

  Widget portraitUI(BuildContext context, widget) {
    return Column(
      children: [
        // Expanded(flex: 1, child: addTransactionUI(context, widget)),
        Expanded(flex: 7, child: totalBalanceUI()),
        BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
          builder: (context, state) {
            if (state is ExpenseTypeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ExpenseTypeLoadedState) {
              arrExpenseType = state.arrExpenseType;
              return Expanded(flex: 12, child: transactionListUI());
            }
            return Container();
          },
        )
      ],
    );
  }

  Widget addTransactionUI(BuildContext context, widget) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpensesScreen(
                      balanceTillNow: arrExpenses.isEmpty
                          ? 0.0
                          : arrExpenses[arrExpenses.length - 1].bal),
                ));
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget totalBalanceUI() {
    var totalBalance = arrExpenses[0].bal!.toDouble().toString();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Spent Till Now',
            style: mTextStyle16(mColor: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$', style: mTextStyle25(mColor: Colors.grey)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${totalBalance.split(".")[0]}',
                    style: mTextStyle52(
                        mColor: Colors.black, fontWeight: FontWeight.w700)),
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                        '.${totalBalance.split(".")[1].length == 1 ? '${totalBalance.split(".")[1]}0' : totalBalance.split(".")[1]}',
                        style: mTextStyle25(mColor: Colors.black))),
              ]))
            ],
          )
        ],
      ),
    );
  }

  Widget transactionListUI() {
    List<String> arrUniqueDates = [];
    List<String> arrUniqueMonth = [];
    for (ExpenseModel expense in arrExpenses) {
      var eachTime = DateTime.parse(expense.time!);
      var date = DateTime.now().day.toString().length == 1
          ? '0${DateTime.now().day}'
          : DateTime.now().day;
      var month = eachTime.month.toString().length == 1
          ? '0${eachTime.month}'
          : eachTime.month;
      var eachDate = '${eachTime.year}-$month-$date';

      var eachMonth = '${eachTime.year}-$month';

      if (!arrUniqueDates.contains(eachDate)) {
        arrUniqueDates.add(eachDate);
      }

      if (!arrUniqueMonth.contains(eachMonth)) {
        arrUniqueMonth.add(eachMonth);
      }
    }
    // print(arrUniqueDates);

    updateDayWiseTransactions(arrUniqueDates);
    updateMonthWiseTransactions(arrUniqueMonth);

    return ListView.builder(
      itemBuilder: (context, index) {
        return mainListItem(index, width!, arrDayWiseExpense[index].toMap());
      },
      itemCount: arrDayWiseExpense.length,
      shrinkWrap: true,
    );
  }

  void updateDayWiseTransactions(List<String> arrUniqueDates) {
    arrDayWiseExpense.clear();

    /*var month = DateTime.now().month.toString().length == 1
        ? '0${DateTime.now().month}'
        : DateTime.now().month;
    var currentDate = '${DateTime.now().year}-$month-${DateTime.now().day}';*/

    for (String eachDate in arrUniqueDates) {
      List<ExpenseModel> eachDayExpenses = [];
      for (ExpenseModel expense in arrExpenses) {
        // print(expense.time.toString());
        // print(eachDate);
        if (expense.time!.contains(eachDate)) {
          print(expense.time!.toString());
          eachDayExpenses.add(expense);
        }
      }

      var dayWiseBalance = 0.0;

      for (ExpenseModel expense in eachDayExpenses) {
        if (expense.type == 1) {
          dayWiseBalance -= expense.amt!;
        } else {
          dayWiseBalance += expense.amt!;
        }
      }

      //List<ExpenseModel> arrOtherExpense = [];
      //arrOtherExpense.addAll(arrExpenses);
      //arrOtherExpense.removeWhere((expense) => expense.time!.contains(currentDate));

      var month = DateTime.now().month.toString().length == 1
          ? '0${DateTime.now().month}'
          : DateTime.now().month;

      var date = DateTime.now().day.toString().length == 1
          ? '0${DateTime.now().day}'
          : DateTime.now().day;

      var currentDate = '${DateTime.now().year}-$month-$date';
      var yesterdayDate =
          '${DateTime.now().year}-$month-${int.parse("$date") - 1}';

      if (eachDate == currentDate) {
        log("each date $eachDate     currentdate $currentDate");
        eachDate = 'Today';
      } else if (eachDate == yesterdayDate) {
        eachDate = 'Yesterday';
      }

      var todayExpense = DayWiseExpenseModel(
          date: eachDate,
          bal: dayWiseBalance.toString(),
          arrExpenses: eachDayExpenses);
      /* var otherDateExpenses = DayWiseExpensesModel(
        date: 'Other', bal: '0.0', arrExpenses: arrOtherExpense);*/

      arrDayWiseExpense.add(todayExpense);
      //arrDayWiseExpense.add(otherDateExpenses);
    }
  }

  void updateMonthWiseTransactions(List<String> arrUniqueMonths) {
    List<Map<String, dynamic>> arrMonthExpenseData = [];
    List<ExpenseModel> arrEachMonthExpense = [];
    for (String eachMonth in arrUniqueMonths) {
      for (ExpenseModel expense in arrExpenses) {
        if (expense.time!.contains(eachMonth)) {
          arrEachMonthExpense.add(expense);
        }
      }

      double eachMonthBal = 0.0;

      for (ExpenseModel expense in arrEachMonthExpense) {
        if (expense.type == 1) {
          eachMonthBal += expense.amt!;
        } else {
          eachMonthBal -= expense.amt!;
        }
      }

      arrMonthExpenseData.add({
        'month': Constants.mapMonth[eachMonth.split('-')[1]],
        'bal': eachMonthBal
      });

      print(arrMonthExpenseData);
    }
  }

  Widget mainListItem(int index, double width, Map dayWiseTransaction) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 11.0, right: 11.0, bottom: 21.0, top: 11.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayWiseTransaction['date'],
                  style: mTextStyle12(mColor: Colors.grey),
                ),
                Text(
                  '\$ ${dayWiseTransaction['bal']}',
                  style: mTextStyle12(mColor: Colors.grey),
                )
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (context, childIndex) {
              return mainChildTransactionItem(
                  (dayWiseTransaction['arrExpenses'][childIndex]
                          as ExpenseModel)
                      .toMap(),
                  context);
            },
            itemCount: dayWiseTransaction['arrExpenses'].length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          )
          /**/
        ],
      ),
    );
  }

  Widget mainChildTransactionItem(Map detailTransaction, BuildContext context) {
    var imgPath;
    for (CategoryModel type in arrExpenseType) {
      if (type.cat_id == detailTransaction['cat_id']) {
        imgPath = type.img_path;
        break;
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Image.asset(imgPath ?? "",
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08),
      title: Text(
        detailTransaction['title'],
        style: mTextStyle16(mColor: Colors.black, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        detailTransaction['desc'],
        style: mTextStyle16(mColor: Colors.black),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$ ${detailTransaction['amt']}',
            style:
                mTextStyle16(mColor: Colors.black, fontWeight: FontWeight.w700),
          ),
          Text(
            '\$ ${detailTransaction['balance']}',
            style: mTextStyle12(mColor: Colors.black),
          )
        ],
      ),
    );
  }
}
