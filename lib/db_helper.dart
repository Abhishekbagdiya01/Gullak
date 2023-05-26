import 'package:expense_tracker/models/category_model.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String EXPENSE_TABLE = "expense";
  static const String EXPENSE_COLUMN_ID = "eid";
  static const String EXPENSE_COLUMN_TITLE = "title";
  static const String EXPENSE_COLUMN_DESC = "desc";
  static const String EXPENSE_COLUMN_AMT = "amt";
  static const String EXPENSE_COLUMN_BAL = "balance";
  static const String EXPENSE_COLUMN_CAT_ID = "cat_id";
  static const String EXPENSE_COLUMN_TYPE = "type";
  static const String EXPENSE_COLUMN_TIME = "time";

  static const String CAT_TABLE = "category";
  static const String CAT_COLUMN_ID = "cat_id";
  static const String CAT_COLUMN_TITLE = "title";
  static const String CAT_COLUMN_PATH = "img_path";

  Future<Database> openDb() async {
    var directory = await getApplicationDocumentsDirectory();
    directory.create(recursive: true);
    var path = directory.path + "expense_db.db";
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'create table $EXPENSE_TABLE($EXPENSE_COLUMN_ID integer primary key autoincrement ,'
            '$EXPENSE_COLUMN_TITLE text,'
            '$EXPENSE_COLUMN_DESC text,'
            '$EXPENSE_COLUMN_AMT real,'
            '$EXPENSE_COLUMN_BAL real,'
            '$EXPENSE_COLUMN_CAT_ID integer,'
            '$EXPENSE_COLUMN_TYPE integer,'
            '$EXPENSE_COLUMN_TIME text)');

        db.execute(
            'create table $CAT_TABLE($CAT_COLUMN_ID integer primary key autoincrement ,'
            '$CAT_COLUMN_TITLE text,'
            '$CAT_COLUMN_PATH text)');

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Cafe",
                    img_path: "assets/expense_types_icons/cafe.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Books",
                    img_path: "assets/expense_types_icons/books.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Coffee",
                    img_path: "assets/expense_types_icons/coffee.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Fast-Food",
                    img_path: "assets/expense_types_icons/fast-food.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Games",
                    img_path: "assets/expense_types_icons/game-controller.png")
                .toMap());

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Movies",
                    img_path: "assets/expense_types_icons/movie.png")
                .toMap());

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Gym",
                    img_path: "assets/expense_types_icons/gym.png")
                .toMap());

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Restaurant",
                    img_path: "assets/expense_types_icons/restaurant.png")
                .toMap());

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Shopping",
                    img_path: "assets/expense_types_icons/shopping.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Travel",
                    img_path: "assets/expense_types_icons/travel.png")
                .toMap());

        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Accessories",
                    img_path: "assets/expense_types_icons/accessories.png")
                .toMap());
        db.insert(
            CAT_TABLE,
            CategoryModel(
                    title: "Cosmetics",
                    img_path: "assets/expense_types_icons/cosmetics.png")
                .toMap());
      },
    );
  }

  Future<int> addExpenses(ExpenseModel expense) async {
    var myDb = await openDb();
    return myDb.insert(EXPENSE_TABLE, expense.toMap());
  }

  Future<List<ExpenseModel>> fetchData() async {
    var myDb = await openDb();
    List<Map<String, dynamic>> data;
    data = await myDb.query(EXPENSE_TABLE);
    List<ExpenseModel> arrExpense = [];

    for (Map<String, dynamic> expense in data) {
      ExpenseModel model = ExpenseModel.fromMap(expense);
      arrExpense.add(model);
    }
    return arrExpense;
  }

  Future<List<CategoryModel>> fetchAllExpenseType() async {
    var myDb = await openDb();
    List<Map<String, dynamic>> dataExpenseType;
    dataExpenseType = await myDb.query(CAT_TABLE);
    List<CategoryModel> arrExpenseType = [];
    for (Map<String, dynamic> expenseType in dataExpenseType) {
      CategoryModel model = CategoryModel.fromMap(expenseType);
      arrExpenseType.add(model);
    }
    return arrExpenseType;
  }
}
