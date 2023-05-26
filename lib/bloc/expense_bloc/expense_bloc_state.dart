part of 'expense_bloc_bloc.dart';

@immutable
abstract class ExpenseBlocState {}

class ExpenseBlocInitialState extends ExpenseBlocState {}

class ExpenseBlocLoadingState extends ExpenseBlocState {}

class ExpenseBlocLoadedState extends ExpenseBlocState {
  List<ExpenseModel> arrExpense;
  ExpenseBlocLoadedState(this.arrExpense);
}

class ExpenseBlocErrorState extends ExpenseBlocState {
  String errorMsg;
  ExpenseBlocErrorState(this.errorMsg);
}
