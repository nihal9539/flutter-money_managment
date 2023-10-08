import 'package:flutter/material.dart';
import 'package:money_managment/db/Transactiondb.dart';
import 'package:money_managment/db/category_db.dart';
import 'package:money_managment/models/Transaction/transaction_model.dart';
import 'package:money_managment/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _CategoryId;

  final _puposeTextEDitingController = TextEditingController();

  final _amountTextEDitingController = TextEditingController();

  @override
  void initState() {
    //ottaTime run akukayollo
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  /*
  Purpose
  Date
  Amount
  Income/Expense
  CetegoryTYpe

   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //purpose
            TextFormField(
              cursorHeight: 25,
              controller: _puposeTextEDitingController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Purpose',
              ),
            ),
            //amount
            TextFormField(
              controller: _amountTextEDitingController,
              cursorHeight: 25,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
              ),
            ),
            //Calender

            TextButton.icon(
              onPressed: () async {
                final _selecterDateTEmp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(
                        days: 30)), //365*100 koduthal 100kolathe date ayi
                    lastDate: DateTime.now());
                if (_selecterDateTEmp == null) {
                  return;
                } else {
                  print(_selecterDateTEmp.toString());
                  setState(() {
                    _selectedDate = _selecterDateTEmp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString()),
            ),

            //RadioButton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _CategoryId = null;
                          });
                        }),
                    Text('Income'),
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.expense,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.expense;
                                _CategoryId = null;
                              });
                            }),
                        Text('Expense'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // CAtegoryTYpe
            DropdownButton<String>(
              hint: const Text('Select one'),
              value: _CategoryId,

              //map -using for convert a list to another

              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDb().incomeCAtegoryListListner
                      : CategoryDb().ExpenseCAtegoryListLIstner)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedCategoryModel = e;
                  },
                );
              }).toList(),

              onChanged: (selectValue) {
                setState(() {
                  _CategoryId = selectValue;
                });
              },
              onTap: () {},
            ),
            ElevatedButton(
              onPressed: () {
                addTrasaction();
                Navigator.of(context).pop();
                TransactionDb.instance.refresh();
              },
              child: Text('Submit'),
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTrasaction() async {
    final _purposeText = _puposeTextEDitingController.text;
    final _amountText = _amountTextEDitingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    // if (_CategoryId == null) {
    //   return;
    // }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    // _selectedDate
    // _selectedCategoryType
    // _CategoryId

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    TransactionDb.instance.addTransaction(_model);
  }
}
