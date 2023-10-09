import 'package:finance_app/bar_graph/bar_graph.dart';
import 'package:finance_app/data/expense_data.dart';
import 'package:finance_app/dateTime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    //get yyyymdd for each  day of this week
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thrusday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    //calculate the max amount in bar graph
    int calculateMax(
        ExpenseData value,
        String sunday,
        String monday,
        String tuesday,
        String wednesday,
        String thrusday,
        String friday,
        String saturday) {
      double? max = 100.0;

      List<double> values = [
        value.calculateDailyExpenseSummary()[sunday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[monday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[tuesday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[wednesday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[thrusday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[friday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[saturday]?.toDouble() ?? 0,
      ];

      //sort array
      values.sort();

      //maximum array value
      max = values.last * 1.2;

      int maxLimit = (max == 0 ? 100 : max.toInt());
      return maxLimit;
    }

    int calculateWeekTotal(
        ExpenseData value,
        String sunday,
        String monday,
        String tuesday,
        String wednesday,
        String thrusday,
        String friday,
        String saturday) {
      List<double> values = [
        value.calculateDailyExpenseSummary()[sunday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[monday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[tuesday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[wednesday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[thrusday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[friday]?.toDouble() ?? 0,
        value.calculateDailyExpenseSummary()[saturday]?.toDouble() ?? 0,
      ];

      //sort array
      int totalamount = 0;
      for (var element in values) {
        totalamount += element.toInt();
      }
      return totalamount;
    }

    return Consumer<ExpenseData>(
        builder: (ctx, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Week Total: ',
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w500, fontSize: 24),
                      ),
                      Text(
                        'Rs ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thrusday, friday, saturday)}',
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w400, fontSize: 28),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: MyBarGraph(
                      maxY: calculateMax(value, sunday, monday, tuesday,
                          wednesday, thrusday, friday, saturday),
                      sunAmount:
                          value.calculateDailyExpenseSummary()[sunday] ?? 0,
                      monAmount:
                          value.calculateDailyExpenseSummary()[monday] ?? 0,
                      tuesAmount:
                          value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                      wedAmount:
                          value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                      thrusAmount:
                          value.calculateDailyExpenseSummary()[thrusday] ?? 0,
                      friAmount:
                          value.calculateDailyExpenseSummary()[friday] ?? 0,
                      satAmount:
                          value.calculateDailyExpenseSummary()[saturday] ?? 0),
                ),
              ],
            ));
  }
}
