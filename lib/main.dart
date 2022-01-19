// import 'dart:html';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
      routes: const {},
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // static String id = 'sign-up';          //firebase
  // final _auth = FirebaseAuth.instance;        //firebase
  // final _formKey = GlobalKey<FormState>();     //firebase

  // late String _email;                                  //firebase
  // late String _password;                               //firebase
  // final GoogleSignIn googleSignIn = GoogleSignIn();    //firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hello There!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Let's start your wonderful journey together....",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: Form(
                      // key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "First Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Last Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            TextFormField(
                            //   onSaved: (emailValue) {        //firebase
                            //   _email = emailValue!;         //firebase
                            // },                                //firebase
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                // errorStyle: TextStyle(color: Colors.black),    //firebase
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                            //   onSaved: (passValue) {
                            //   _password = passValue!;
                            //  },
                              decoration: InputDecoration(
                                hintText: "Re-enter password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                // errorStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.8);
                                    }
                                    return Colors.blue;
                                  },
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ),
                              ),
                              // minWidth: double.infinity,       //use in MaterialButton
                              // height: 60,                     //use in MaterialButton
                              onPressed: () async{},
                              child: const Text(
                                "    Sign Up    ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )),
                          ],
                        ),
                      ),
                    ),
                    // decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage('assets/images/flutter.png')),
                    // ),    
                  ),
                  
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        const Text("Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "         Login    ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

// class UpdateWidget extends State {
  
// }