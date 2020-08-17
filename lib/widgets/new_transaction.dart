import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNew;

  NewTransaction(this.addNew);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNew(enteredTitle, enteredAmount, _selectedDate,);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
//                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2,),),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
//                      onChanged: (val) {
//                        titleInput = val;
//                      },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
//                      onChanged: (val) {
//                        amountInput = val;
//                      },
              onSubmitted: (_) => _selectedDate != null ? submitData() : _presentDatePicker(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
