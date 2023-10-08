import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/db/Transactiondb.dart';
import 'package:money_managment/db/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';

import '../../models/Transaction/transaction_model.dart';

class ScreensTransaction extends StatelessWidget {
  const ScreensTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refressUI();
    TransactionDb.instance.refresh();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                startActionPane: ActionPane(motion: DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransactionDb.instance.deleteTransaction(_value.id!);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ]),
                key: Key(_value.id!),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _value.type == CategoryType.income
                          ? Color.fromARGB(255, 19, 247, 27)
                          : Color.fromARGB(255, 242, 35, 20),
                      radius: 50,
                      child: Text(
                        parseDate(_value.date),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text(_value.category.name),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _sptit = _date.split(' '); //space important aan
    return '\t${_sptit.last}\n${_sptit.first}';
    // return '${date.day}\n${date.month}';
  }
}
