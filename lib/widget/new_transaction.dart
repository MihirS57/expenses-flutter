import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime dateChosen = DateTime.now();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    final date = dateChosen;
    if (title.isEmpty || amount <= 0 || date == null) {
      return;
    }
    widget.addTransaction(title, amount, date);
    Navigator.of(context).pop(); //pops the topmost widget on the screen
  }

  void triggerDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateChosen = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        10), //view insets provided height of overlaying object above the current widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      onSubmitted: (_) => submitData(),
                      //onChanged: (value) => titleInput = value,
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      //onChanged: (value) => amountInput = value,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => submitData(),
                      controller: amountController,
                    ),
                    Container(
                      height: 60,
                      child: Row(children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: Text(dateChosen == null
                                ? 'Default: ${DateFormat.yMMMd().format(DateTime.now())}'
                                : 'Date Picked: ${DateFormat.yMMMd().format(dateChosen)}')),
                        FlatButton(
                            onPressed: triggerDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ))
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: submitData,
                      ),
                    )
                  ],
                ))));
  }
}
