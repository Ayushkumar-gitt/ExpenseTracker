import 'package:expense_tracker/expense_add.dart';
import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> registeredExpenses = [
    ExpenseModel(
      title: "Movie",
      amount: 12.33,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    ExpenseModel(
      title: "Office work",
      amount: 14,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void openaddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return ExpenseAdd(onExpenseAdd: addExpense);
      },
    );
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text("List is empty, Please add some expenses"),
    );
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [IconButton(onPressed: openaddExpense, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chart'),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
