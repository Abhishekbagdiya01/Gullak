import 'package:expense_tracker/db_helper.dart';

class CategoryModel {
  int? cat_id;
  String title;
  String img_path;

  CategoryModel({this.cat_id, required this.title, required this.img_path});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        cat_id: map[DbHelper.CAT_COLUMN_ID],
        title: map[DbHelper.CAT_COLUMN_TITLE],
        img_path: map[DbHelper.CAT_COLUMN_PATH]);
  }
  Map<String, dynamic> toMap() {
    return {
      DbHelper.CAT_COLUMN_TITLE: title,
      DbHelper.CAT_COLUMN_PATH: img_path
    };
  }
}
