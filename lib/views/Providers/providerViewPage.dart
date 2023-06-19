import 'package:flutter/material.dart';
import 'package:examenfinalwask_e/widgets/bottomNavbarWidget.dart';

class ProviderViewPage extends StatelessWidget {
  final String developer;
  final String encharged;
  final String mail;
  final String phone;

  const ProviderViewPage({
    Key? key,
    required this.developer,
    required this.encharged,
    required this.mail,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${developer.toString()}"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => BottomNavbarWidget()),
              );
            },
            child: Text("volver"),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Text("${encharged}"),
          ),
          Center(
            child: Text("${mail}"),
          ),
          Center(
            child: Text("${phone}"),
          ),
        ],
      ),
    );
  }
}
