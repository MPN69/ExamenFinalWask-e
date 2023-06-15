import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/views/Home/loginPage.dart';
import 'package:waske_final_exam/widgets/bottomNavbarWidget.dart';
import 'package:waske_final_exam/widgets/loadingWidget.dart';

class InicialScreenSelector extends StatelessWidget {
  const InicialScreenSelector({Key? key}) : super(key: key);

  Future<bool> isSignedIn() async {
    GoogleSignIn signIn = GoogleSignIn();
    bool isSignedIn = await signIn.isSignedIn();
    return isSignedIn;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (snapshot.hasData) {
                return const BottomNavbarWidget();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong when SigningIn!"),
                );
              } else {
                return LoginPage();
              }
            }),
      );
}
