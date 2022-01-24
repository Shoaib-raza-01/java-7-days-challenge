import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:jsdc/main.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/util/google_signin.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    // await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}

// // for email provider

// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   late Rx<User?> _user; // access user details
//   FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   void onReady() {
//     super.onReady();
//     _user = Rx<User?>(auth.currentUser);
//     _user.bindStream(auth.userChanges()); //our user will be notified
//     ever(_user, _initialScreeen);
//   }

//   _initialScreeen(User? user) {
//     if (user == null) {
//       Get.offAll(() => FirstScreen());
//     } else {
//       Get.offAll(() => Dashboard());
//     }
//   }

//   void register(String email, password) async {
//     try {
//       await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       Get.snackbar(
//         "About User",
//         " User message",
//         backgroundColor: Colors.blue,
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: const Text(
//           "Account creation failed",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         messageText: Text(
//           e.toString(),
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       );
//     }
//   }

//   void login(String email, password) async {
//     try {
//       await auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       Get.snackbar(
//         "About login",
//         " Login message",
//         backgroundColor: Colors.blue,
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: const Text(
//           "Login failed",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         messageText: Text(
//           e.toString(),
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       );
//     }
//   }

//   void logOut() async{
//     await auth.signOut();

//   }
// }

// FirebaseAuth auth = FirebaseAuth.instance;
// final googleSignIn = GoogleSignIn();
// Future<bool> googleSignIn() async {
//   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   if (googleSignInAccount != null) {
//     GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//     AuthCredential credential = GoogleAuthProvider.getCre
//     return Future.value(true);
//   }
// }

