import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/home/home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyHomeScreen.selectedIndex,
        builder: (context, updatedInd, child) {
          return CurvedNavigationBar(
            index: updatedInd,
            backgroundColor: CustomColors.commonClr,
            height: 50,
            animationCurve: Curves.fastOutSlowIn,
            items: const [Icon(Icons.home_outlined), Icon(Icons.category)],
            onTap: (value) {
              MyHomeScreen.selectedIndex.value = value;
            },
          );
        });
  }
}
