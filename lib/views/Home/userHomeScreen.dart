import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenfinalwask_e/views/Employees/employeeListPage.dart';
import 'package:examenfinalwask_e/views/Employees/employeeViewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:examenfinalwask_e/Google/services/googleSignIn.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("Clientes")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<bool>(
                  future: isSignedIn(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return Text(
                        "Aqui estoy yo",
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueGrey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(snapshot.data!["Imagen"]!),
                ),
                const SizedBox(height: 30),
                Text(
                  snapshot.data!["Nombre"]! + " " + snapshot.data!["Apellido"]!,
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  snapshot.data!["Genero"]!,
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  snapshot.data!["Correo"],
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    GoogleSignIn signIn = GoogleSignIn();
                    bool isSignedIn = await signIn.isSignedIn();
                    if (isSignedIn) {
                      FirebaseAuth.instance.signOut();
                      provider.googleLogout();
                    } else {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    child: Text("Sign Out"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<bool> isSignedIn() async {
  GoogleSignIn signIn = GoogleSignIn();
  bool isSignedIn = await signIn.isSignedIn();
  return isSignedIn;
}
