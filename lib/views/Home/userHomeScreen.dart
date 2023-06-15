import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:waske_final_exam/Google/services/googleSignIn.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usr = FirebaseAuth.instance;

    final user = FirebaseFirestore.instance
        .collection("Clientes")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged In"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              GoogleSignIn signIn = GoogleSignIn();
              bool isSignedIn = await signIn.isSignedIn();
              if (isSignedIn) {
                FirebaseAuth.instance.signOut();
                provider.googleLogout();
              } else {
                FirebaseAuth.instance.signOut();
              }
            },
            style: TextButton.styleFrom(
              primary: Colors.white.withOpacity(0.3),
            ),
            child: const Text("SignOut"),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          }
          return Container(
            alignment: Alignment.center,
            color: Colors.blueGrey.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<bool>(
                  future: isSignedIn(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return Text("Aqui estoy yo");
                    } else {
                      return Container();
                    }
                  },
                ),
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 24),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(snapshot.data!["Imagen"]!),
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  snapshot.data!["Nombre"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(color: Colors.green, thickness: 2),
                Text(
                  snapshot.data!["Correo"],
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
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
