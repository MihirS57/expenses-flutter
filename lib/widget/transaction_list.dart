import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function deleteTx;
  TransactionList(this._userTransaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: _userTransaction.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        child: Text(
                          '₹${_userTransaction[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userTransaction[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //getCorrectDateFormat(tx.date.toString()),
                          DateFormat.yMMMd()
                              .format(_userTransaction[index].date),
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () =>
                                deleteTx(_userTransaction[index].id),
                            icon: Icon(Icons.delete, color: Colors.red))
                      ],
                    ),
                  ],
                ));
              },
              itemCount: _userTransaction.length,
            ),
    );
    /*Column(
        children: (_userTransaction).map((tx) {
      return Container(
        width: double.infinity,
        child: Card(
            child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2)),
                child: Text(
                  '₹${tx.amount}',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  //getCorrectDateFormat(tx.date.toString()),
                  DateFormat.yMMMd().format(tx.date),
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                )
              ],
            )
          ],
        )
        ),
        color: Colors.white,
      );
    }
    ).toList());*/
  }
}
