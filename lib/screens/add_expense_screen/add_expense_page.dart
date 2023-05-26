import 'package:expense_tracker/bloc/cat_bloc/bloc/expense_type_bloc.dart';
import 'package:expense_tracker/bloc/expense_bloc/expense_bloc_bloc.dart';
import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/custom_widget/custom_textfield.dart';
import 'package:expense_tracker/models/category_model.dart';
import 'package:expense_tracker/models/expense_model.dart';

import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensesScreen extends StatefulWidget {
  AddExpensesScreen({required this.balanceTillNow});
  var balanceTillNow;
  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  var expenseController = TextEditingController();

  var titleController = TextEditingController();

  var descController = TextEditingController();

  var _selectedIndex = -1;
  var isLoading = true;

  var selectedDate = DateTime.now();

  var selectedTime = TimeOfDay.now();
  List<CategoryModel> arrExpenseType = [];
  String defaultDropDownValue = 'Debit';
  List dropDownListItem = ['Debit', 'Credit'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchExpenseType());
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: orientation == Orientation.portrait
            ? mainUI(isLight)
            : landscapeUi(isLight, width));
  }

  Widget mainUI(isLight) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: mTextStyle25(
                              mColor:
                                  isLight ? MyColor.bgBColor : MyColor.bgWColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Text("EXPENSE",
                        style: mTextStyle25(
                            mColor:
                                isLight ? MyColor.bgBColor : MyColor.bgWColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CustomTextFieldV2(
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                controller: expenseController,
                hintText: "000",
                icon: Icons.currency_rupee,
                textInputType: TextInputType.number,
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            CustomTextFieldV2(
              color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              controller: titleController,
              icon: Icons.title,
              hintText: "Add title",
              textInputType: TextInputType.text,
            ),
            CustomTextFieldV2(
              color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              controller: descController,
              icon: Icons.description,
              hintText: "Add description",
            ),
            SizedBox(
              height: 10,
            ),

            DropdownButton(
              icon: Icon(Icons.arrow_drop_down),
              items: dropDownListItem
                  .map((value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: mTextStyle16(),
                        ),
                        value: value,
                      ))
                  .toList(),
              value: defaultDropDownValue,
              onChanged: (dynamic value) {
                defaultDropDownValue = value;
                setState(() {});
              },
            ),

            SizedBox(
              height: 10,
            ),
            BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
              builder: (context, state) {
                if (state is ExpenseTypeLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ExpenseTypeLoadedState) {
                  arrExpenseType = state.arrExpenseType;
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 60,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              shrinkWrap: true,
                              itemCount: state.arrExpenseType.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  _selectedIndex = index;

                                  setState(() {});
                                },
                                child: _selectedIndex == index
                                    ? Container(
                                        padding: EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          border: Border.all(width: 1),
                                        ),
                                        child: Image.asset(state
                                            .arrExpenseType[index].img_path),
                                      )
                                    : Image.asset(
                                        state.arrExpenseType[index].img_path),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: _selectedIndex == -1
                        ? Text(
                            "Select Expenses",
                            style: mTextStyle16(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Selected - ",
                                style: mTextStyle16(),
                              ),
                              Image.asset(
                                state.arrExpenseType[_selectedIndex].img_path,
                                height: 40,
                                width: 40,
                              )
                            ],
                          ),
                  );
                } else {
                  return Text("Something went wrong");
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());

                      selectedDate = datePicked ?? DateTime.now();

                      setState(() {});
                    },
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: mTextStyle16(),
                    )),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () async {
                      TimeOfDay? timePicked = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      selectedTime = timePicked ?? TimeOfDay.now();
                      setState(() {});
                    },
                    child: Text(
                      "${selectedTime.format(context)}",
                      style: mTextStyle16(),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: BlocListener<ExpenseBloc, ExpenseBlocState>(
                listener: (context, state) {
                  if (state is ExpenseBlocLoadingState) {
                    // isLoading = true;
                    setState(() {});
                  } else if (state is ExpenseBlocLoadedState) {
                    // isLoading = false;

                    // Navigator.pop(context);
                  }
                },
                child: MaterialButton(
                  color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                  onPressed: () {
                    var newBalance = 0.0;
                    if (defaultDropDownValue == "Debit") {
                      newBalance = widget.balanceTillNow -
                          double.parse(expenseController.text.toString());
                    } else {
                      newBalance = widget.balanceTillNow +
                          double.parse(expenseController.text.toString());
                    }

                    if (_selectedIndex > -1) {
                      BlocProvider.of<ExpenseBloc>(context).add(
                        AddExpenseEvent(
                          model: ExpenseModel(
                            title: titleController.text,
                            desc: descController.text,
                            amt: double.parse(expenseController.text),
                            bal: newBalance,
                            cat_id: arrExpenseType[_selectedIndex].cat_id,
                            type: defaultDropDownValue == 'Debit' ? 1 : 2,
                            time: DateTime.now().toString(),
                          ),
                        ),
                      );
                      isLoading = false;
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: isLoading
                      ? Text(
                          "Save",
                          style: mTextStyle25(
                              fontWeight: FontWeight.bold,
                              mColor: isLight
                                  ? MyColor.bgWColor
                                  : MyColor.bgBColor),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget landscapeUi(isLight, width) {
    return Container(
        padding: EdgeInsets.only(left: width * .20, right: width * .20),
        color: isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
        child: mainUI(isLight));
  }
}
