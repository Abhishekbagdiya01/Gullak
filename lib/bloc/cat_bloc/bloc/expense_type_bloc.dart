import 'package:bloc/bloc.dart';
import 'package:expense_tracker/db_helper.dart';
import 'package:expense_tracker/models/category_model.dart';

import 'package:meta/meta.dart';

part 'expense_type_event.dart';
part 'expense_type_state.dart';

class ExpenseTypeBloc extends Bloc<ExpenseTypeEvent, ExpenseTypeState> {
  ExpenseTypeBloc() : super(ExpenseTypeInitialState()) {
    on<FetchExpenseType>((event, emit) async {
      // TODO: implement event handler
      emit(ExpenseTypeLoadingState());
      var arrExpenseType = await DbHelper().fetchAllExpenseType();
      emit(ExpenseTypeLoadedState(arrExpenseType));
    });
  }
}
