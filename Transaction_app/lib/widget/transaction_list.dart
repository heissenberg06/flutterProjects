import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List txList;
  TransactionList(this.txList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 75),
      height: 370,
      child: txList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transaction',
                  style: Theme.of(context).textTheme.headline6,
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
              itemBuilder: ((ctx, index) {
                return Card(
                  child: Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      )),
                      padding: EdgeInsets.all(10),
                      child:
                          Text('\$${txList[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Theme.of(context).primaryColor,
                              )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(txList[index].title,
                            style: Theme.of(context).textTheme.headline6),
                        Text(
                          DateFormat.yMMMd()
                              .format(txList[index].date), //dateyi araştır
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ]),
                );
              }),
              itemCount: txList.length,
            ),
    );
  }
}
