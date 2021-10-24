import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widget/new_transaction.dart';
import 'package:flutter_complete_guide/widget/transaction_list.dart';
import '../model/transaction.dart';
import './widget/ChartWidget.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput, amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<Transaction> _userTransaction = [
    /* Transaction(
        id: 't1', title: 'New Shoes', amount: 69.420, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Phone', amount: 420.69, date: DateTime.now()) */
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransactions(String title, double amount, DateTime dateTime) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: dateTime);

    setState(() {
      _userTransaction.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  String getCorrectDateFormat(String str) {
    //replacement would be use: https://pub.dev/packages/intl
    String date = str.split(' ')[0];
    String day = date.split('-')[2];
    String month = date.split('-')[1];
    String year = date.split('-')[0];
    date = "";
    if (day == '1') {
      date += "1st ";
    } else if (day == '2') {
      date += '2nd ';
    } else if (day == '3') {
      date += '3rd ';
    } else {
      date += day + 'th ';
    }
    date += months[(int.parse(month)) - 1] + ", " + year;
    return date;
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransactions));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLandscape)
                  Row(
                    children: [
                      Text('Show Chart'),
                      Switch(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        },
                      )
                    ],
                  ),
                if (!isLandscape)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.4,
                      child: ChartWidget(_recentTransactions))

                //NewTransaction(_addTransactions),
                ,
                if (!isLandscape)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.6,
                      child: TransactionList(
                          _userTransaction, _deleteTransaction)),
                if (isLandscape && _showChart)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: ChartWidget(_recentTransactions)),
                if (isLandscape && !_showChart)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: TransactionList(
                          _userTransaction, _deleteTransaction)),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )));
  }
}
