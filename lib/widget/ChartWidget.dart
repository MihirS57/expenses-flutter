import 'package:flutter/material.dart';
import '../model/transaction.dart';
import './ChartBar.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransactions;
  ChartWidget(this.recentTransactions);

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactions.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending));
              }).toList()
            ],
          ),
        ));
  }
}
