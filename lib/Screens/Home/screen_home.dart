import 'package:flutter/material.dart';
import 'package:money_managment/Screens/Home/widgets/botton_navigation.dart';
import 'package:money_managment/Screens/Transaction/screen_add_transaction.dart';
import 'package:money_managment/Screens/Transaction/screen_transaction.dart';
import 'package:money_managment/Screens/catagory/category_add_popup.dart';
import 'package:money_managment/Screens/catagory/screen_catagory.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedintnotifier = ValueNotifier(0);

  final _pages = [ScreensTransaction(), ScreensCatagory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("MONEY MANAGER"),
          centerTitle: true,
        ),
        bottomNavigationBar: const MOneyManagerBottomNavigation(),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedintnotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedintnotifier.value == 0) {
              print("AddTransaction");
              Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            } else {
              showCAtrgoryAddPopup(context);
              //   print("Add Catagory");
              //
              //          final _sample = CategoryModel(
              //            id: DateTime.now().microsecond.toString(),
              //          name: 'Travel',
              //        type: CategoryType.expense,
              //    );
              //  CategoryDb().insertCategory(_sample);

            }
          },
          child: Icon(Icons.add),
        ));
  }
}
