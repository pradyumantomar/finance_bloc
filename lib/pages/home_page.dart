import 'package:finance_app/components/expense_summary.dart';
import 'package:finance_app/components/expense_tile.dart';
import 'package:finance_app/data/expense_data.dart';
import 'package:finance_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController? amountController;
  TextEditingController? descriptionController;
  DateTime? dateValue;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    dateValue = DateTime.now();

    //prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  void dispose() {
    amountController!.dispose();
    descriptionController!.dispose();
    super.dispose();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Form(
                key: _globalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder(
                              options: ValidationBuilder.globalOptions)
                          .maxLength(5)
                          .minLength(1)
                          .regExp(RegExp('[0-9]'), 'only Number')
                          .build(),
                      controller: amountController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Amount',
                          contentPadding: EdgeInsets.all(4)),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: ValidationBuilder()
                          .maxLength(30)
                          .minLength(3)
                          .regExp(
                              RegExp('[a-zA-Z0-9]'), 'only String or Number')
                          .build(),
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Description',
                          contentPadding: EdgeInsets.all(4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: InkWell(
                        child: (dateValue != null)
                            ? Text(DateFormat.yMMMEd().format(dateValue!))
                            : const Text('Select Date'),
                        onTap: () => DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            currentTime: DateTime.now(),
                            minTime: DateTime(2023), onConfirm: (date) {
                          dateValue = date;
                        }, maxTime: DateTime.now()),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: saveAction,
                  child: Text(
                    'Save',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                ),
                MaterialButton(
                  onPressed: cancelAction,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                ),
              ],
            ));
  }

  void saveAction() {
    if (_globalKey.currentState?.validate() == false) {
      return;
    }

    ExpenseItem newExpense = ExpenseItem(
        expenseAmount: int.parse(amountController!.value.text),
        expenseDate: dateValue!,
        expenseDescription: descriptionController!.text);

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.of(context).pop();
    clearController();
  }

  void cancelAction() {
    Navigator.of(context).pop();
    clearController();
  }

  void clearController() {
    amountController?.clear();
    descriptionController?.clear();
    dateValue = DateTime.now();
  }

  void deleteExpense(ExpenseItem expenseItem) {
    Provider.of<ExpenseData>(context, listen: false).removeExpense(expenseItem);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (ctx, value, child) => Scaffold(
        backgroundColor: Colors.grey[400],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ListView(
              children: [
                Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: ExpenseSummary(
                    startOfWeek: value.startOfWeekDate(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) {
                      return ExpenseTile(
                          deleteTapped: (context) =>
                              deleteExpense(value.getAllExpenseList()[index]),
                          expenseTitle: value
                              .getAllExpenseList()[index]
                              .expenseDescription,
                          expenseAmount: value
                              .getAllExpenseList()[index]
                              .expenseAmount
                              .toString(),
                          expenseDateValue:
                              value.getAllExpenseList()[index].expenseDate);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
