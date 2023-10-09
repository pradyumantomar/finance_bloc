class ExpenseItem {
  final String expenseDescription;
  final DateTime expenseDate;
  final int expenseAmount;

  ExpenseItem(
      {required this.expenseAmount,
      required this.expenseDate,
      required this.expenseDescription});
}
