import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waske_final_exam/views/Clients/addClientPage.dart';
import 'package:waske_final_exam/widgets/loginButtonWidget.dart';
import 'package:waske_final_exam/widgets/textFormfieldWidget.dart';

import '../../Google/services/googleSignIn.dart';
import '../../firebase/services/authService.dart';
import '../../widgets/googleButtonWidgetTest.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final TextEditingController email_controller =
      TextEditingController(text: "");
  final TextEditingController password_controller =
      TextEditingController(text: "");

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.shade900,
                Colors.lightBlue.shade600,
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const FaIcon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 140,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormFieldWidget(
                    hint: "Email",
                    icon: Icons.person,
                    obscureText: false,
                    type: TextInputType.text,
                    controller: email_controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hint: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    type: TextInputType.text,
                    controller: password_controller,
                  ),
                  const SizedBox(height: 30.0),
                  LoginButtonWidget(
                    context: context,
                    formKey: formKey,
                    email_controller: email_controller,
                    password_controller: password_controller,
                  ),
                  //if (usr != null) ...[Text("Aqui estoy io")],
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {}
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddClientPage(),
                          ),
                        );
                        // print('tonto ahahaahahahah');
                        // Registro exitoso, puedes redirigir al usuario a otra página o mostrar un mensaje de éxito.
                      } catch (error) {
                        // Ocurrió un error durante el registro, puedes mostrar un mensaje de error al usuario.
                      }
                    },
                    child: Text('Register'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    label: const Text("  Sign Up with Google"),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                  ),
                  GoogleButtonWidget(
                    imagePath: 'images/Google.png',
                    onTap: () => AuthService().signInWithGoogle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
