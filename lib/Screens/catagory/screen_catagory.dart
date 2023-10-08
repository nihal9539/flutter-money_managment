import 'package:flutter/material.dart';
import 'package:money_managment/Screens/catagory/listExpence.dart';
import 'package:money_managment/Screens/catagory/listIncome.dart';
import 'package:money_managment/db/category_db.dart';

class ScreensCatagory extends StatefulWidget {
  const ScreensCatagory({Key? key}) : super(key: key);

  @override
  State<ScreensCatagory> createState() => _ScreensCatagoryState();
}

class _ScreensCatagoryState extends State<ScreensCatagory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refressUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              tabs: const [
                Tab(text: "Income"),
                Tab(text: "Expense"),
              ]),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                LIstIncomeCatrgory(),
                ListExpenseCategory(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
