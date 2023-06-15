import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/firebase/services/clientServices.dart';

class AuthService {
  signInWithGoogle() async {
    //Begin sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //Obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //Create credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    var auth = await FirebaseAuth.instance.signInWithCredential(credential);
    var exist = await clientExistByMail(auth.user?.email ?? "");
    if (!exist) {
      print("me vale verga jajajaja ${auth.user!.uid}");
      addClient(
          auth.user!.displayName!,
          auth.user!.displayName!,
          auth.user!.displayName!,
          auth.user!.email!,
          auth.user!.photoURL!,
          auth.user!.phoneNumber ?? "none",
          "none",
          auth.user!.uid);
    }

    //Sign in
    return auth;
  }
}
