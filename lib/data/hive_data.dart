import 'package:finance_app/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  //reference the box
  final _myBox = Hive.box('local_db');

  //add list
  void saveExpenseData(List<ExpenseItem> allExpense) {
    //storing list in list<list<dynamic>>>
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expenses in allExpense) {
      List<dynamic> expenseFormatted = [
        expenses.expenseDescription,
        expenses.expenseAmount,
        expenses.expenseDate
      ];

      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put('all_expenses', allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List<dynamic> savedExpenses = _myBox.get('all_expenses') ?? [];
    //convert in all form
    List<ExpenseItem> allExpenses = [];
    for (var element in savedExpenses) {
      String description = element[0];
      int amount = element[1];
      DateTime dateTime = element[2];

      ExpenseItem expenses = ExpenseItem(
          expenseAmount: amount,
          expenseDate: dateTime,
          expenseDescription: description);
      allExpenses.add(expenses);
    }
    return allExpenses;
  }
}
