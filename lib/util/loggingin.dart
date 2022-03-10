import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsdc/main.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/screens/otp_screen.dart';

class LoggingIn extends StatelessWidget {
  const LoggingIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return const OtpScreen();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong...."),
                );
              } else {
                return const FirstScreen();
              }
            }),
      );
}
