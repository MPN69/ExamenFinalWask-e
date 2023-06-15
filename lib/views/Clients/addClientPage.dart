import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebase/services/clientServices.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key? key}) : super(key: key);

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  TextEditingController client_name_controller =
      TextEditingController(text: "");
  TextEditingController client_last_name_controller =
      TextEditingController(text: "");
  TextEditingController client_email_controller =
      TextEditingController(text: "");
  TextEditingController client_gender_controller =
      TextEditingController(text: "");
  TextEditingController client_image_controller =
      TextEditingController(text: "");
  TextEditingController client_password_controller =
      TextEditingController(text: "");
  TextEditingController client_phone_controller =
      TextEditingController(text: "");
  TextEditingController client_id_controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Client"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: client_name_controller,
              decoration: const InputDecoration(
                hintText: "Client Name",
              ),
            ),
            TextField(
              controller: client_last_name_controller,
              decoration: const InputDecoration(
                hintText: "Client Last Name",
              ),
            ),
            TextField(
              controller: client_email_controller,
              decoration: const InputDecoration(
                hintText: "Client Email",
              ),
            ),
            TextField(
              controller: client_password_controller,
              decoration: const InputDecoration(
                hintText: "Client Password",
              ),
            ),
            TextField(
              controller: client_gender_controller,
              decoration: const InputDecoration(
                hintText: "Client Gender",
              ),
            ),
            TextField(
              controller: client_phone_controller,
              decoration: const InputDecoration(
                hintText: "Client Phone Number",
              ),
            ),
            TextField(
              controller: client_id_controller,
              decoration: const InputDecoration(
                hintText: "Client ID",
              ),
            ),
            TextField(
              controller: client_image_controller,
              decoration: const InputDecoration(
                hintText: "Client image",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var usr =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: client_email_controller.text,
                  password: client_password_controller.text,
                );
                await addClient(
                        client_name_controller.text,
                        client_last_name_controller.text,
                        client_gender_controller.text,
                        client_email_controller.text,
                        client_image_controller.text,
                        client_phone_controller.text,
                        client_password_controller.text,
                        usr.user!.uid)
                    .then((_) {
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
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
