import 'package:expense_tracker/bloc/cat_bloc/bloc/expense_type_bloc.dart';
import 'package:expense_tracker/bloc/expense_bloc/expense_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense_screen/add_expense_page.dart';
import 'package:expense_tracker/screens/home_screen/home_screen.dart';
import 'package:expense_tracker/screens/splash_screen/splash_screen.dart';
import 'package:expense_tracker/ui_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ExpenseTypeBloc(),
    ),
    BlocProvider(
      create: (context) => ExpenseBloc(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: MyColor.bgBColor,
        canvasColor: MyColor.bgBColor,
      ),
      theme: ThemeData(
          primarySwatch: createMaterialColor(MyColor.bgWColor),
          backgroundColor: MyColor.bgWColor,
          canvasColor: MyColor.bgWColor),
      home: HomeScreen(),
    );
  }
}
