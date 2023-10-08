import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_picker/flutter_picker.dart';

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
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
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
                  children: [
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(4)),
                    ),
                    TextFormField(
                      controller: descriptionController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        child: (dateValue != null)
                            ? Text(dateValue.toString())
                            : const Text('Select Date'),
                        onTap: () => DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            currentTime: DateTime.now(),
                            minTime: DateTime(2023), onConfirm: (date) {
                          setState(() {
                            dateValue = date;
                          });
                        }, maxTime: DateTime.now()),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: saveAction,
                  child: Text('Save'),
                ),
                MaterialButton(
                  onPressed: cancelAction,
                  child: Text('Cancel'),
                ),
              ],
            ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
