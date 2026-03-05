class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}


class ExpenseList {
  final String date;
  final String category;
  final double amount;

  ExpenseList({required this.date, required this.category, required this.amount});

  factory ExpenseList.fromJson(Map<String, dynamic> json) {
    return ExpenseList(
      date: json['date'],
      category: json['category_name'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }
}

class DebtManagementList {
  final String cardNumber;  // Expected to be bank_name
  final int    pendingAmount;
  final int    totalAmount;
  final String dueDate;
  final String id;
  final int status;

  DebtManagementList({required this.cardNumber, required this.pendingAmount, required this.dueDate, required this.id, required this.status, required this.totalAmount });

  factory DebtManagementList.fromJson(Map<String, dynamic> json) {
    return DebtManagementList(
      cardNumber: json['bank_name'],
      pendingAmount: json['pending_amount'],
      totalAmount: json['total_amount'],
      dueDate: json['due_date'],
      id: json['id'].toString(),
      status: json['status'],
    );
  }
}