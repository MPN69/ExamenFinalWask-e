import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:waske_final_exam/views/Games/gameListPage.dart';
import 'package:waske_final_exam/views/Home/userHomeScreen.dart';
import 'package:waske_final_exam/views/Providers/providerListPage.dart';
import 'package:waske_final_exam/views/Sales/saleListPage.dart';

import '../views/Clients/clientListPage.dart';
import '../views/Employees/employeeListPage.dart';
import '../views/Stores/storeListPage.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const GameListPage(),
    const SaleListPage(),
    const UserHomeScreen(),
    const ProviderListPage(),
    const StoreListPage(),
    const ClientListPage(),
    const EmployeeListPage(),

    //Aqui solo hay que acomodar las vistas uwu
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
              text: 'Games',
            ),
            GButton(
              icon: Icons.people_alt_outlined,
              text: 'Clients',
            ),
            GButton(
              icon: LineIcons.users,
              text: 'Employees',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Provider',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Provider',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Me',
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
