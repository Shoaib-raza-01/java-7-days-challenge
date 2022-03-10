import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsdc/screens/reset_pass.dart';
import 'package:jsdc/util/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String emailController;
  late String passwordController;

  final auth = FirebaseAuth.instance;
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //   background image   //
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
                Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/images/logobgr.png',
                    )),
                  ),
                ),
                Container(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 15.0, left: 10, right: 10.0),
                      child: Card(
                        // color: Colors.amber[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Java 7 Days Challenge",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, right: 14, left: 14, bottom: 8),
                              child: TextFormField(
                                onSaved: (newEmail) {
                                  emailController = newEmail!;
                                },
                                // controller: emailController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    icon: Icon(Icons.email),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, right: 14, left: 14, bottom: 8),
                              child: TextFormField(
                                onSaved: (newPassword) {
                                  passwordController = newPassword!;
                                },
                                // controller: passwordController,
                                obscureText: !_showPassword,

                                // Get.snackbar(
                                //   "About password",
                                //   " Password message",
                                //   backgroundColor: Colors.blue,
                                //   snackPosition: SnackPosition.BOTTOM,
                                //   titleText: const Text(
                                //     "Invalid password",
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                //   messageText: const Text(
                                //     "Field can't be empty",
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // );

                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _togglevisibility();
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    icon: const Icon(Icons.lock),
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ResetPassScreen()));
                                  },
                                  child: const Text("Forgot your Password?"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                _formkey.currentState!.save();
                                try {
                                  final user =
                                      await auth.signInWithEmailAndPassword(
                                          email: emailController.trim(),
                                          password: passwordController.trim());
                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushNamed(MyRoutes.dashboard);
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    "About Login",
                                    " Login message",
                                    backgroundColor: Colors.blue,
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: const Text(
                                      "Invalid password",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    messageText: const Text(
                                      "Field can't be empty",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 110,
                                margin:
                                    const EdgeInsets.only(top: 25, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Don't have an account?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Get.back(),
                                        text: "  Create",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
