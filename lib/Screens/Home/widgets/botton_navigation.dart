import 'package:flutter/material.dart';
import 'package:money_managment/Screens/Home/screen_home.dart';

class MOneyManagerBottomNavigation extends StatelessWidget {
  const MOneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedintnotifier,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedintnotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Transactions"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Categories")
            ]);
      },
    );
  }
}
