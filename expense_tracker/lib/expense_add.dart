import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({super.key, required this.onExpenseAdd});

  final void Function(ExpenseModel expense) onExpenseAdd;
  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  var title = TextEditingController();
  DateTime? date;
  Category category = Category.leisure;
  var amount = TextEditingController();

  void datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      date = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(amount.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount < 0;
    if (isAmountInvalid || title.text.trim().isEmpty || date == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text("Please enter all the values properly"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onExpenseAdd(
      ExpenseModel(
        title: title.text,
        amount: enteredAmount,
        date: date!,
        category: category,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: title,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  controller: amount,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Text(
                    date == null ? "No date selected" : formatter.format(date!),
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: datepicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              DropdownButton(
                value: category,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toString().toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    category = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  submitExpenseData();
                },
                child: Text("Save Expenses"),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
