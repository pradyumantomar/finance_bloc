import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {super.key,
      required this.expenseTitle,
      required this.expenseAmount,
      required this.expenseDateValue,
      required this.deleteTapped});

  final String expenseTitle;
  final String expenseAmount;
  final DateTime expenseDateValue;
  final Function(BuildContext)? deleteTapped;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.delete,
          backgroundColor: Colors.redAccent,
        ),
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.settings,
          backgroundColor: Colors.greenAccent,
        )
      ]),
      child: ListTile(
        title: Text(
          expenseTitle,
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
        subtitle: Text(DateFormat.MMMEd().format(expenseDateValue),
            style: GoogleFonts.aBeeZee(fontSize: 16)),
        trailing:
            Text('Rs $expenseAmount', style: GoogleFonts.aBeeZee(fontSize: 16)),
      ),
    );
  }
}
