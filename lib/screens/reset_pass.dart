import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  late String resetEmail;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: const Image(
              image: AssetImage('assets/images/blue-wallpaper-7.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/images/logobgr.png',
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, bottom: 25),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Hey User!",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, bottom: 8),
                child: Text(
                  "We will send an Email to reset your account password.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, bottom: 28),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Kindly refer your mail.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  onChanged: (reEmail) {
                    setState(() {
                      resetEmail = reEmail;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  auth.sendPasswordResetEmail(email: resetEmail);
                },
                child: const Text("Get Reset Link"),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
