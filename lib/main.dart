import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jsdc/screens/buy.dart';
import 'package:jsdc/screens/courses.dart';
import 'package:jsdc/screens/otp_screen.dart';
import 'package:jsdc/screens/resume_page.dart';
import 'package:jsdc/screens/contact.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/screens/login.dart';
import 'package:jsdc/screens/notification.dart';
import 'package:jsdc/util/google_SignIn.dart';
import 'package:jsdc/util/loggingin.dart';
import 'package:jsdc/util/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'High importance channel', //id
    'High importance notofication', //title
    importance: Importance.max,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up : ${message.messageId}');
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
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
          // darkTheme: ThemeData.dark(),
          // themeMode:ThemeMode.system,
          home: const LoggingIn(),
          routes: {
            MyRoutes.dashboard: (context) => const Dashboard(),
            MyRoutes.login: (context) => const LoginPage(),
            MyRoutes.notification: (context) => const NotificationPage(),
            MyRoutes.contactUs: (context) => const ContactUsPage(),
            MyRoutes.resumeform: (context) => const ResumeFormPage(),
            MyRoutes.otpscreen: (context) => const OtpScreen(),
            MyRoutes.courses: (context) => const CoursesPage(),
            MyRoutes.buy: (context) => const BuyScreen(),
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
  bool submitValid = false;
  String _emailController = "";
  String _passwordController = "";
  String _cnfPassController = "";

  final auth = FirebaseAuth.instance;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _show = false;
  void _visible() {
    setState(() {
      _show = !_show;
    });
  }

  bool _see = false;
  void _toggle() {
    setState(() {
      _see = !_see;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                    image: AssetImage('assets/images/blue-wallpaper-7.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  top: 120,
                  left: 85,
                  child: Text(
                    "Hello There!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                ),
                const Positioned(
                  top: 190,
                  left: 50,
                  child: Text(
                    "Let's start your wonderful journey together....",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.67,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
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
                                    onSaved: (emailValue) {
                                      _emailController = emailValue!;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (passValue) {
                                      _passwordController = passValue!;
                                    },
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
                                        hintText: "Password",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        )),
                                  ),
                                  TextFormField(
                                    onSaved: (cnfpassValue) {
                                      _cnfPassController = cnfpassValue!;
                                    },
                                    obscureText: !_see,
                                    decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _toggle();
                                          },
                                          child: Icon(
                                            _see
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: "Re-enter password",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (_passwordController.trim() ==
                                          _cnfPassController.trim()) {
                                        // setState(() {
                                        //   changeButton = true;
                                        // });
                                        // await Future.delayed(
                                        //     const Duration(seconds: 1));
                                        formkey.currentState!.save();
                                        try {
                                          await auth
                                              .createUserWithEmailAndPassword(
                                                  email:
                                                      _emailController.trim(),
                                                  password: _passwordController
                                                      .trim())
                                              .then((value) => Navigator.of(
                                                      context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          const OtpScreen())));
                                        } catch (e) {
                                          Get.snackbar(
                                            "About Account",
                                            " Account message",
                                            backgroundColor: Colors.blue,
                                            snackPosition: SnackPosition.BOTTOM,
                                            titleText: const Text(
                                              "Account creation failed",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            messageText: Text(
                                              e.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
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
                                  Row(
                                    children: [
                                      const Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 90,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, MyRoutes.login);
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          InkWell(
                                            child: Container(
                                              height: 45,
                                              width: 220,
                                              margin: const EdgeInsets.only(
                                                  top: 25),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.black),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final provider = Provider.of<
                                                      GoogleSignInProvider>(
                                                  context,
                                                  listen: false);
                                              provider.googleLogin();
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                              height: 45,
                                              width: 220,
                                              margin: const EdgeInsets.only(
                                                  top: 25),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.black),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Get.snackbar(
                                                "Facebook Error",
                                                " Unavailable",
                                                backgroundColor: Colors.blue,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                titleText: const Text(
                                                  "Unavailable",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                messageText: const Text(
                                                  "This feature is not yet available.\n It will be available in further updates.",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }, //function for facebook
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
