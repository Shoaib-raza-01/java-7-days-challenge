import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jsdc/screens/array.dart';
import 'package:jsdc/screens/bool_string.dart';
import 'package:jsdc/screens/if_else_stats.dart';
import 'package:jsdc/screens/jump_stats.dart';
import 'package:jsdc/screens/loops.dart';
import 'package:jsdc/screens/oop_concept.dart';
import 'package:jsdc/screens/operator_math.dart';
import 'package:jsdc/screens/resume_page.dart';
import 'package:jsdc/screens/sort_search.dart';
import 'package:jsdc/screens/switchcase.dart';
import 'package:jsdc/screens/syntax.dart';
import 'package:jsdc/screens/contact.dart';
import 'package:jsdc/screens/dashboard.dart';
import 'package:jsdc/screens/datatypes.dart';
import 'package:jsdc/screens/login.dart';
import 'package:jsdc/screens/notification.dart';
import 'package:jsdc/screens/topics.dart';
import 'package:jsdc/screens/variables.dart';
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
  print('A bg message just showed up : ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp().then((value) => Get.put(AuthController()));

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
            MyRoutes.syntax: (context) => const SyntaxPage(),
            MyRoutes.notification: (context) => const NotificationPage(),
            MyRoutes.contactUs: (context) => const ContactUsPage(),
            MyRoutes.topics: (context) => const TopicsPage(),
            MyRoutes.variable: (context) => const VariablePage(),
            MyRoutes.datatypes: (context) => const  DatatypePage(),
            MyRoutes.operator: (context) => const OperatorPage(),
            MyRoutes.boolstr: (context) => const StringBoolPage(),
            MyRoutes.ifelse: (context) => const IfElseStatPage(),
            MyRoutes.switchcase: (context) => const SwitchCase(),
            MyRoutes.loops: (context) => const LoopsPage(),
            MyRoutes.jump: (context) => const JumpPage(),
            MyRoutes.array: (context) => const ArrayPage(),
            MyRoutes.sort: (context) => const SortSearchPage(),
            MyRoutes.oopconcept: (context) => const OOPconceptPage(),
            MyRoutes.resumeform: (context) => const ResumeFormPage(),
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
  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();
  // var cnfPassControlller = TextEditingController();
  String _emailController = "";
  String _passwordController = "";
  String _cnfPassControlller = "";
  final auth = FirebaseAuth.instance;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.height,
              child: const Image(
                image: AssetImage('assets/images/blue-wallpaper-7.jpg'),
                fit: BoxFit.cover,
              ),
              // child:Image.asset('assets/images/blue-wallpaper-7.jpg'),
              // decoration: const BoxDecoration(
              //   image: DecorationImage(

              //   ),
              // ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              // height: double.infinity,
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
                          height: 15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/2,
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
                                      // errorStyle: TextStyle(color: Colors.black),    //firebase
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (passValue) {
                                      _passwordController = passValue!;
                                    },
                                    // controller: passwordController,
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
                                    onSaved: (cnfpassValue) {
                                      _cnfPassControlller = cnfpassValue!;
                                    },
                                    // controller: cnfPassControlller,
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (_passwordController.trim() ==
                                          _cnfPassControlller.trim()) {
                                        formkey.currentState!.save();
                                        try {
                                          final new_user = await auth
                                              .createUserWithEmailAndPassword(
                                                  email:
                                                      _emailController.trim(),
                                                  password: _passwordController
                                                      .trim());
                                          if (new_user != null) {
                                            Navigator.pushNamed(
                                                context, MyRoutes.dashboard);
                                          }
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
                                        if (_passwordController == null) {
                                          setState(() {
                                            changeButton = true;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1));
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
                                          // fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, MyRoutes.login);
                                        },
                                        child: const Text(
                                          "         Login    ",
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
                                              //for adaptive height and width
                                              // width: MediaQuery.of(context).size.width / 2,
                                              // height: MediaQuery.of(context).size.height / 18,
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
                                            }, //function for google
                                          ),
                                          InkWell(
                                            child: Container(
                                              // width: MediaQuery.of(context).size.width / 2,
                                              // height: MediaQuery.of(context).size.height / 18,
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
