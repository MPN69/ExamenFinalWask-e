import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bottomNavbarWidgetFirebase.dart';

class LoginButtonWidget extends StatelessWidget {
  final dynamic context;
  final dynamic formKey;
  TextEditingController email_controller = TextEditingController(text: "");
  TextEditingController password_controller = TextEditingController(text: "");

  LoginButtonWidget({
    super.key,
    required this.context,
    required this.formKey,
    required this.email_controller,
    required this.password_controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      child: Text(
        ' LOGIN ',
        style: TextStyle(
          color: Colors.grey[900],
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email_controller.text,
              password: password_controller.text,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavbarWidgetFirebase(),
              ),
            );
          } catch (error) {
            print(error
                .toString()); // Verifica si se imprime el error en la consola
            showDialog(
              context: context,
              builder: (BuildContext context) {
                print(
                    "Showing alert dialog"); // Verifica si se llega a este punto
                return AlertDialog(
                  title: const Text("Couldn't Login"),
                  content: const Text("Please try again with the correct data"),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      },
    );
  }
}
