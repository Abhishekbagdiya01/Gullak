import 'package:bloc/bloc.dart';
import 'package:expense_tracker/db_helper.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:meta/meta.dart';

part 'expense_bloc_event.dart';
part 'expense_bloc_state.dart';

class ExpenseBloc extends Bloc<ExpenseBlocEvent, ExpenseBlocState> {
  ExpenseBloc() : super(ExpenseBlocInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      // TODO: implement event handler
      emit(ExpenseBlocLoadingState());
      var check = await DbHelper().addExpenses(event.model);
      if (check > 0) {
        var arrExpense = await DbHelper().fetchData();
        emit(ExpenseBlocLoadedState(arrExpense));
      } else {
        emit(ExpenseBlocErrorState("No Expense added "));
      }
    });

    on<FetchAllExpensesEvent>((event, emit) async {
      emit(ExpenseBlocLoadingState());

      var arrExpense = await DbHelper().fetchData();
      emit(ExpenseBlocLoadedState(arrExpense));
    });
  }
}
