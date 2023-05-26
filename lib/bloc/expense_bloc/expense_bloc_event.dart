part of 'expense_bloc_bloc.dart';

@immutable
abstract class ExpenseBlocEvent {}

class AddExpenseEvent extends ExpenseBlocEvent {
  ExpenseModel model;
  AddExpenseEvent({required this.model});
}

class FetchAllExpensesEvent extends ExpenseBlocEvent {}
