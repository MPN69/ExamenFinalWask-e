import 'package:flutter/material.dart';

import '../../firebase/services/employeeServices.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  TextEditingController employee_name_controller =
      TextEditingController(text: "");
  TextEditingController employee_last_name_controller =
      TextEditingController(text: "");
  TextEditingController employee_email_controller =
      TextEditingController(text: "");
  TextEditingController employee_image_controller =
      TextEditingController(text: "");
  TextEditingController employee_phone_controller =
      TextEditingController(text: "");
  TextEditingController employee_id_controller =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: employee_name_controller,
              decoration: const InputDecoration(
                hintText: "Employee Name",
              ),
            ),
            TextField(
              controller: employee_last_name_controller,
              decoration: const InputDecoration(
                hintText: "Employee Last Name",
              ),
            ),
            TextField(
              controller: employee_email_controller,
              decoration: const InputDecoration(
                hintText: "Employee Email",
              ),
            ),
            TextField(
              controller: employee_phone_controller,
              decoration: const InputDecoration(
                hintText: "Employee Phone Number",
              ),
            ),
            TextField(
              controller: employee_id_controller,
              decoration: const InputDecoration(
                hintText: "Employee ID",
              ),
            ),
            TextField(
              controller: employee_image_controller,
              decoration: const InputDecoration(
                hintText: "Employee image",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addEmployee(
                  employee_name_controller.text,
                  employee_last_name_controller.text,
                  employee_email_controller.text,
                  employee_image_controller.text,
                  employee_phone_controller.text,
                  employee_id_controller.text,
                ).then((_) {
                  employee_name_controller.text = "";
                  employee_last_name_controller.text = "";
                  employee_email_controller.text = "";
                  employee_image_controller.text = "";
                  employee_phone_controller.text = "";
                  employee_id_controller.text = "";
                  Navigator.pushNamed(context, '/');
                });
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
