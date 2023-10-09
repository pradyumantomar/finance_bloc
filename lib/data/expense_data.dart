import 'package:finance_app/data/hive_data.dart';
import 'package:finance_app/dateTime/date_time_helper.dart';
import 'package:finance_app/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expense
  List<ExpenseItem> overallExpenseList = [];

  // get all expense
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add expense
  void addNewExpense(ExpenseItem expense) {
    overallExpenseList.add(expense);
    notifyListeners();
    db.saveExpenseData(overallExpenseList);
  }

  //delete expese
  void removeExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveExpenseData(overallExpenseList);
  }

  // get Weekday (mon,tue, etc) from dateTime Object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thru';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';

      default:
        return '';
    }
  }

  // get the date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get today
    DateTime today = DateTime.now();

    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;

    //goback to find sunday
  }

  //convert overall list of the expense  into daily expense summary

  Map<String, int> calculateDailyExpenseSummary() {
    Map<String, int> dailyExpenseSummary = {
      // date(yyyymmdd) : amountTotalforDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.expenseDate);
      int amount = expense.expenseAmount;

      if (dailyExpenseSummary.containsKey(date)) {
        int currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
