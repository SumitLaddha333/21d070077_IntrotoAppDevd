import 'package:flutter/material.dart';

void main() => runApp(BudgetTrackerApp());

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.purple[700],
        secondaryHeaderColor: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Groceries', expenses: [
      Expense(amount: 50.0, description: 'Vegetables'),
      Expense(amount: 30.0, description: 'Snacks'),
    ]),
    Category(name: 'Bills', expenses: [
      Expense(amount: 100.0, description: 'Electricity'),
      Expense(amount: 50.0, description: 'Water'),
    ]),
    // Add more categories and expenses as needed
  ];

  final double salary = 3000.0; // Update the salary amount here

  double get totalExpenses {
    return categories
        .expand((category) => category.expenses)
        .map((expense) => expense.amount)
        .fold(0, (previousValue, amount) => previousValue + amount);
  }

  double get balance {
    return salary - totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello User!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Total Income: \$${salary.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Balance: \$${balance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Categories:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  double totalCategoryExpenses = category.expenses
                      .map((expense) => expense.amount)
                      .fold(
                          0, (previousValue, amount) => previousValue + amount);

                  return Card(
                    elevation: 2,
                    child: ExpansionTile(
                      title: Text(category.name),
                      leading: Icon(Icons.category, color: Colors.purple[700]),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: category.expenses.length,
                          itemBuilder: (context, index) {
                            final expense = category.expenses[index];
                            return ListTile(
                              title: Text(
                                  'Amount: \$${expense.amount.toStringAsFixed(2)}'),
                              subtitle:
                                  Text('Description: ${expense.description}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Implement code to delete expense
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total Category Expenses: \$${totalCategoryExpenses.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement code to add new expense
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Category {
  final String name;
  final List<Expense> expenses;

  Category({required this.name, required this.expenses});
}

class Expense {
  final double amount;
  final String description;

  Expense({required this.amount, required this.description});
}
