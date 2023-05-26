import 'package:expense_tracker/db_helper.dart';

class ExpenseModel {
  int? eid;
  String? title;
  String? desc;
  double? amt;
  double? bal;
  int? cat_id;
  int? type;
  String? time;

  ExpenseModel(
      {this.eid,
      this.title,
      this.desc,
      this.amt,
      this.bal,
      this.cat_id,
      this.type,
      this.time});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        eid: map[DbHelper.EXPENSE_COLUMN_ID],
        title: map[DbHelper.EXPENSE_COLUMN_TITLE],
        desc: map[DbHelper.EXPENSE_COLUMN_DESC],
        amt: map[DbHelper.EXPENSE_COLUMN_AMT],
        bal: map[DbHelper.EXPENSE_COLUMN_BAL],
        cat_id: map[DbHelper.EXPENSE_COLUMN_CAT_ID],
        type: map[DbHelper.EXPENSE_COLUMN_TYPE],
        time: map[DbHelper.EXPENSE_COLUMN_TIME]);
  }

  Map<String, dynamic> toMap() {
    return {
      // DbHelper.EXPENSE_COLUMN_ID: eid,
      DbHelper.EXPENSE_COLUMN_TITLE: title,
      DbHelper.EXPENSE_COLUMN_DESC: desc,
      DbHelper.EXPENSE_COLUMN_AMT: amt,
      DbHelper.EXPENSE_COLUMN_BAL: bal,
      DbHelper.EXPENSE_COLUMN_CAT_ID: cat_id,
      DbHelper.EXPENSE_COLUMN_TYPE: type,
      DbHelper.EXPENSE_COLUMN_TIME: time
    };
  }
}
