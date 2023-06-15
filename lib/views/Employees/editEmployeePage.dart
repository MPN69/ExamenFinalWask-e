import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/employeeServices.dart';

class EditEmployeePage extends StatefulWidget {
  final String uid;
  final String name;
  final String lastName;
  final String email;
  final String image;
  final String phone;
  final String id;

  const EditEmployeePage(
      {Key? key,
      required this.uid,
      required this.name,
      required this.lastName,
      required this.email,
      required this.image,
      required this.phone,
      required this.id})
      : super(key: key);

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  TextEditingController employee_name_controller = TextEditingController();
  TextEditingController employee_last_name_controller = TextEditingController();
  TextEditingController employee_email_controller = TextEditingController();
  TextEditingController employee_image_controller = TextEditingController();
  TextEditingController employee_phone_controller = TextEditingController();
  TextEditingController employee_id_controller = TextEditingController();
  String employee_uid = "";

  @override
  void initState() {
    super.initState();
    employee_name_controller.text = widget.name;
    employee_last_name_controller.text = widget.lastName;
    employee_email_controller.text = widget.email;
    employee_image_controller.text = widget.image;
    employee_phone_controller.text = widget.phone;
    employee_id_controller.text = widget.id;
    employee_uid = widget.uid;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Employee"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await deleteEmployee(employee_uid).then(
                (_) => Navigator.pushNamed(context, '/'),
              );
            },
            style: TextButton.styleFrom(
              primary: Colors.white.withOpacity(0.3),
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: employee_id_controller,
              decoration: const InputDecoration(
                hintText: "ID",
              ),
            ),
            TextField(
              controller: employee_name_controller,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            TextField(
              controller: employee_last_name_controller,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              controller: employee_email_controller,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: employee_phone_controller,
              decoration: const InputDecoration(
                hintText: "Phone",
              ),
            ),
            TextField(
              controller: employee_image_controller,
              decoration: const InputDecoration(
                hintText: "Profile Picture",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateEmployee(
                  employee_uid,
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
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
