import 'package:flutter/material.dart';

import '../../widgets/bottomNavbarWidget.dart';

class ClientViewPage extends StatelessWidget {
  final String clientName;
  final String clientLastName;
  final String clientGender;
  final String clientMail;
  final String clientImage;
  final String clientPhone;

  const ClientViewPage(
      {Key? key,
      required this.clientName,
      required this.clientLastName,
      required this.clientGender,
      required this.clientMail,
      required this.clientImage,
      required this.clientPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${clientName.toString()}"),
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
            child: Text("${clientLastName}"),
          ),
          Center(
            child: Text("${clientGender}"),
          ),
          Center(
            child: Text("${clientMail}"),
          ),
          Center(
            child: Text("${clientPhone}"),
          ),
          Center(
            child: Image(
              image: NetworkImage(
                clientImage.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
