import 'package:flutter/material.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/screens/login.dart';
import 'package:jsdc/util/google_SignIn.dart';
import 'package:jsdc/util/loggingin.dart';
import 'package:jsdc/util/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoggingIn(),
          routes: {
            MyRoutes.dashboard: (context) =>  Dashboard(),
            MyRoutes.login: (context) => const LoginPage(),
          },
        ),
      );
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool changeButton = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cnfPassControlller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                          key: formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.end,
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    // errorStyle: TextStyle(color: Colors.black),    //firebase
                                  ),
                                  // validator: (_val) {
                                  //   if (_val!.isEmpty) {
                                  //     return "Cant't be empty";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  // onChanged: (val) {
                                  //   email = val;
                                  // },
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: !_showPass,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _toggle();
                                      },
                                      child: Icon(
                                        _showPass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: cnfPassControlller,
                                  obscureText: !_show,
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _visible();
                                        },
                                        child: Icon(
                                          _show
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintText: "Confirm password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                                InkWell(
                                  onTap: () async {
                                      if(passwordController.text.trim() == cnfPassControlller.text.trim()){
                                        AuthController.instance.register(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                        setState(() {
                                      changeButton = true;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                      }  else{
                                        Get.snackbar(
                                          "About Password",
                                          " Password message",
                                          backgroundColor: Colors.blue,
                                          snackPosition: SnackPosition.BOTTOM,
                                          titleText: const Text(
                                            "Account creation failed",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          messageText: const Text(
                                            "Password didn't matched, re-enter password",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }

                                    
                                    // Navigator.pushNamed(
                                    //     context, MyRoutes.dashboard);
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
                          //for adaptive height and width
                          // width: MediaQuery.of(context).size.width / 2,
                          // height: MediaQuery.of(context).size.height / 18,
                          height: 45,
                          width: 220,
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
                            ),
                          ),
                        ),
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        }, //function for google
                      ),
                      InkWell(
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 2,
                          // height: MediaQuery.of(context).size.height / 18,
                          height: 45,
                          width: 220,
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
      ),
    );
    // );
  }
}
