import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/clientServices.dart';

class EditClientPage extends StatefulWidget {
  final String uid;
  final String name;
  final String lastName;
  final String gender;
  final String email;
  final String image;
  final String phone;
  final String password;
  final String id;

  const EditClientPage(
      {Key? key,
      required this.uid,
      required this.name,
      required this.lastName,
      required this.gender,
      required this.email,
      required this.image,
      required this.phone,
      required this.password,
      required this.id})
      : super(key: key);

  @override
  State<EditClientPage> createState() => _EditClientPageState();
}

class _EditClientPageState extends State<EditClientPage> {
  TextEditingController client_name_controller = TextEditingController();
  TextEditingController client_last_name_controller = TextEditingController();
  TextEditingController client_email_controller = TextEditingController();
  TextEditingController client_gender_controller = TextEditingController();
  TextEditingController client_image_controller = TextEditingController();
  TextEditingController client_password_controller = TextEditingController();
  TextEditingController client_phone_controller = TextEditingController();
  TextEditingController client_id_controller = TextEditingController();
  String client_uid = "";

  @override
  void initState() {
    super.initState();
    client_name_controller.text = widget.name;
    client_last_name_controller.text = widget.lastName;
    client_email_controller.text = widget.email;
    client_gender_controller.text = widget.gender;
    client_image_controller.text = widget.image;
    client_password_controller.text = widget.password;
    client_phone_controller.text = widget.phone;
    client_id_controller.text = widget.id;
    client_uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Client"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await deleteClient(client_uid).then(
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
              controller: client_id_controller,
              decoration: const InputDecoration(
                hintText: "ID",
              ),
            ),
            TextField(
              controller: client_name_controller,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            TextField(
              controller: client_last_name_controller,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              controller: client_email_controller,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: client_gender_controller,
              decoration: const InputDecoration(
                hintText: "Gender",
              ),
            ),
            TextField(
              controller: client_password_controller,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            TextField(
              controller: client_phone_controller,
              decoration: const InputDecoration(
                hintText: "Phone",
              ),
            ),
            TextField(
              controller: client_image_controller,
              decoration: const InputDecoration(
                hintText: "Profile Picture",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateClient(
                  client_uid,
                  client_name_controller.text,
                  client_last_name_controller.text,
                  client_gender_controller.text,
                  client_email_controller.text,
                  client_image_controller.text,
                  client_phone_controller.text,
                  client_password_controller.text,
                  client_id_controller.text,
                ).then((_) {
                  client_name_controller.text = "";
                  client_last_name_controller.text = "";
                  client_gender_controller.text = "";
                  client_email_controller.text = "";
                  client_image_controller.text = "";
                  client_phone_controller.text = "";
                  client_password_controller.text = "";
                  client_id_controller.text = "";
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
