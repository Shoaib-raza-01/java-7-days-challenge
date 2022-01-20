// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/screens/login.dart';
import 'package:jsdc/util/routes.dart';
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
      routes: {
        MyRoutes.dashboard: (context) => const Dashboard(),
        MyRoutes.login: (context) => const LoginPage(),
      },
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
  bool changeButton = false;
  bool _showPass = false;
  void _toggle() {
    setState(() {
      _showPass = !_showPass;
    });
  } 
  bool _show = false;
  void _visible() {
    setState(() {
      _show = !_show;
    });
  } 
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
                      height: MediaQuery.of(context).size.height / 2,
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
                                obscureText: !_showPass,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _toggle();
                                    },
                                    child: Icon(
                                      _showPass ? Icons.visibility : Icons
                                          .visibility_off, color: Colors.grey,
                                    ),
                                  ),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              TextFormField(
                                obscureText: !_show,
                                //   onSaved: (passValue) {
                                //   _password = passValue!;
                                //  },
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _visible();
                                    },
                                    child: Icon(
                                      _show ? Icons.visibility : Icons
                                          .visibility_off, color: Colors.grey,
                                    ),
                                  ),
                                  hintText: "Re-enter password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // errorStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              // ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty
                              //           .resolveWith<Color>(
                              //         (Set<MaterialState> states) {
                              //           if (states
                              //               .contains(MaterialState.pressed)) {
                              //             return Theme.of(context)
                              //                 .colorScheme
                              //                 .primary
                              //                 .withOpacity(0.8);
                              //           }
                              //           return Colors.blue;
                              //         },
                              //       ),
                              //       shape: MaterialStateProperty.all<
                              //           RoundedRectangleBorder>(
                              //         RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(40.0),
                              //         ),
                              //       ),
                              //     ),
                              //     // minWidth: double.infinity,       //use in MaterialButton
                              //     // height: 60,                     //use in MaterialButton
                              //     onPressed: () async {},
                              //     child: const Text(
                              //       "    Sign Up    ",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //         fontSize: 16,
                              //         color: Colors.white,
                              //       ),
                              //     )
                              // ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    changeButton = true;
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                      Navigator.pushNamed(context, MyRoutes.dashboard);
                                },
                                child: AnimatedContainer(
                                    height: changeButton ? 50 : 40,
                                    width: changeButton ? 50 : 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                          changeButton ? 50 : 40),
                                    ),
                                    duration: const Duration(seconds: 1),
                                    child: changeButton
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                        ),
                                ),
                              ),
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
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.login);
                            },
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
                    const SizedBox(
                      height: 6,
                    ),
                    InkWell(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 18,
                          margin: const EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/google.png'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ))),
                      onTap: () {}, //function for google
                    ),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 18,
                        margin: const EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/facebook.png'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                'Sign in with Facebook',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {}, //function for facebook
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
