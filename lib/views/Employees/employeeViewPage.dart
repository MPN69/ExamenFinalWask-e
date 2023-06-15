import 'package:flutter/material.dart';

import '../../widgets/bottomNavbarWidget.dart';

class EmployeeViewPage extends StatelessWidget {
  final String employeeName;
  final String employeeLastName;
  final String employeeMail;
  final String employeePicture;
  final String employeePhone;

  const EmployeeViewPage(
      {Key? key,
      required this.employeeName,
      required this.employeeLastName,
      required this.employeeMail,
      required this.employeePicture,
      required this.employeePhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${employeeName.toString()}"),
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
            child: Text("${employeeLastName}"),
          ),
          Center(
            child: Text("${employeeMail}"),
          ),
          Center(
            child: Text("${employeeMail}"),
          ),
          Center(
            child: Text("${employeePhone}"),
          ),
          Center(
            child: Image(
              image: NetworkImage(
                employeePicture.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
