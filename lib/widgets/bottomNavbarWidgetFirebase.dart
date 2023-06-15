import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:waske_final_exam/views/Games/gameListPage.dart';
import 'package:waske_final_exam/views/Home/userHomeScreen.dart';
import 'package:waske_final_exam/views/Stores/storeListPage.dart';

import '../views/Employees/employeeListPage.dart';

class BottomNavbarWidgetFirebase extends StatefulWidget {
  const BottomNavbarWidgetFirebase({Key? key}) : super(key: key);

  @override
  State<BottomNavbarWidgetFirebase> createState() =>
      _BottomNavbarWidgetFirebaseState();
}

class _BottomNavbarWidgetFirebaseState
    extends State<BottomNavbarWidgetFirebase> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    GameListPage(),
    StoreListPage(),
    EmployeeListPage(),
    UserHomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          backgroundColor: Colors.white,
          gap: 8,
          activeColor: Colors.grey[100]!,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[800]!,
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineIcons.gamepad,
              text: 'Juegos',
            ),
            GButton(
              icon: Icons.people_alt_outlined,
              text: 'Clientes',
            ),
            GButton(
              icon: LineIcons.users,
              text: 'Empleados',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Yo',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
