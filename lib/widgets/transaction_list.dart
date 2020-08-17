import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteData;

  TransactionList(this.userTransactions, this.deleteData) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: userTransactions.isEmpty
          ? Column(
        children: <Widget>[
          Text(
            "No transactions added yet",
            style: Theme
                .of(context)
                .textTheme
                .title,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      )
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5,),
            elevation: 5,
            child: ListTile(
              //list tile is another option instad of card, leading is the first thing,
//                  circle avatar is the round widget, mostly used for image

//              alternative of CircleAvatar
//              leading: Container(
//                height: 60, width: 60, decoration: BoxDecoration(color: Theme
//                  .of(context)
//                  .primaryColor, shape: BoxShape.circle),
//              )

              leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                      '\$${userTransactions[index].amount.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(
              userTransactions[index].title,
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(userTransactions[index].date),
            ),
            trailing: IconButton(icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: (){
              deleteData(userTransactions[index].id);
              },
              ),
          ),);

//                return Card(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.symmetric(
//                          horizontal: 15,
//                          vertical: 10,
//                        ),
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: Theme.of(context).primaryColor,
//                            width: 2,
//                          ),
//                        ),
//                        padding: EdgeInsets.all(10),
//                        child: Text(
//                          '\$${userTransactions[index].amount.toStringAsFixed(2)}',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 20,
//                            color: Theme.of(context).primaryColor,
//                          ),
//                        ),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            userTransactions[index].title,
////                      style: TextStyle(
////                        fontWeight: FontWeight.bold,
////                        fontSize: 16,
////                      ),
//                            style: Theme.of(context).textTheme.title,
//                          ),
//                          Text(
////                            tx.date.toString(), to change date format
////                            go to pub.dev dateformat, copy and paste version no in pubspec.yaml file below flutter version
//                            DateFormat.yMMMd()
//                                .format(userTransactions[index].date),
//                            style: TextStyle(
//                              color: Colors.grey,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                );
        },
        itemCount: userTransactions.length,
//        This use for column or listView but not ListViewBuilder
//        children: userTransactions.map((tx) {
//        }).toList(),
      ),
    );
  }
}
