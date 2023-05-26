import 'package:expense_tracker/models/expense_model.dart';

class DayWiseExpenseModel {
  String date;
  String bal;
  List<ExpenseModel> arrExpenses;

  DayWiseExpenseModel(
      {required this.date, required this.bal, required this.arrExpenses});

  factory DayWiseExpenseModel.fromMap(Map<String, dynamic> map) {
    return DayWiseExpenseModel(
        date: map['date'], bal: map['bal'], arrExpenses: map['arrExpenses']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'bal': bal,
      'arrExpenses': arrExpenses,
    };
  }
}
