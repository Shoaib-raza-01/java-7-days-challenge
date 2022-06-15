import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jsdc/main.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../util/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController qualifyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late AnimationController _controller1;
  late Animation _animation1;
  AnimationStatus _status1 = AnimationStatus.dismissed;
  bool active = false;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  String name = "User";

  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);

    //for tick controller in courses card

    _controller1 = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _animation1 = Tween(end: 1.0, begin: 0.0).animate(_controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status1 = status;
      });

    //for sending notification to user
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // 'channel.description',
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print("A new onmessageOpenApp was published1");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> _submitForm() async {
    try {
      await FirebaseFirestore.instance.collection("FORTUNE_CAREER").add({
        'name': nameController.text,
        'email': emailController.text,
        'qualify': qualifyController.text,
        'number': numberController.text,
        'location': locationController.text
      });
      Get.snackbar(
        "Form submitted",
        " Submitted",
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Form Submitted",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          "Your response has been recorder. We will notify you soon.",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Form not submitted",
        "Not Submitted",
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Form Not Submitted",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          "We can't accept your respose right now, please try again after sometime or check your internet connectivity.",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: const Center(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Java 7 Days Challenge",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15),
                    //     child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         (() {
                    //           if (user.displayName != null) {
                    //             return "Hey " + user.displayName! + "\n!";
                    //           } else {
                    //             return "Hey " + name + "!";
                    //           }
                    //         })(),
                    //         style: const TextStyle(
                    //             fontSize: 20, fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text("banner1\n\n\n\n\n\n\n"),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text("banner2"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.grey[400],
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Container(
                                Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            color: Colors.white,
                                            child: Center(
                                              child: Column(
                                                children: const [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 40,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/java_logo.png'),
                                                      ),
                                                    ),
                                                  ),
                                                  Text("CORE JAVA"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            color: Colors.white,
                                            child: Center(
                                              child: Column(
                                                children: const [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 40,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/java_logo.png'),
                                                      ),
                                                    ),
                                                  ),
                                                  Text("ADVANCED JAVA"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                                // Container(
                                Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            color: Colors.white,
                                            child: Center(
                                              child: Column(
                                                children: const [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 40,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/resume_logo.jpg'),
                                                      ),
                                                    ),
                                                  ),
                                                  Text("RESUME BUILDER"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed(MyRoutes.buy);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              color: Colors.white,
                                              child: Center(
                                                child: Column(
                                                  children: const [
                                                    SizedBox(
                                                      height: 60,
                                                      width: 40,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/question_logo.png'),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("INTERVIEW QUESTIONS"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                      child: Text("Youtube Videos"),
                    ),
                    Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015)
                        ..rotateY(pi * _animation1.value),
                      child: SizedBox(
                        child: _animation1.value <= 0.5
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 236, 233, 233),
                                      shadowColor: Colors.black,
                                      child: Stack(
                                        children: [
                                          Center(
                                              child: Image.asset(
                                                  'assets/images/SA_LOGO.png')),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              "Contents",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 97, 94, 94),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 40,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Intensive counselling.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 60,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Resume preperation by our experts.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 80,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Profile building to get calls from big MNC.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 100,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Guide to prepare for the most asked question \n   \"Tell Me About Yourself\".",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 135,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Interview Question Bank and skill training by \n   our experts.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 170,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Get recommended calls from our known HR\n    community.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 205,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                "-  Insure 100% Job Guarantee within two month.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            right: 15,
                                            child: InkWell(
                                              onTap: () {
                                                if (_status1 ==
                                                    AnimationStatus.dismissed) {
                                                  _controller1.forward();
                                                } else {
                                                  _controller1.reverse();
                                                }
                                              },
                                              child: const Icon(
                                                Icons.info_outline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 236, 233, 233),
                                        shadowColor: Colors.black,
                                        child: Stack(
                                          children: [
                                            Center(
                                                child: Image.asset(
                                                    'assets/images/SA_LOGO.png')),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 10),
                                              child: Text(
                                                "How this program will help you",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 97, 94, 94),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 15,
                                              right: 15,
                                              child: InkWell(
                                                onTap: () {
                                                  if (_status1 ==
                                                      AnimationStatus
                                                          .dismissed) {
                                                    _controller1.forward();
                                                  } else {
                                                    _controller1.reverse();
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.info_outline,
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              top: 40,
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Expanded(
                                                  child: Text(
                                                    "-  In this program “Get Your Fortune Career” we guide\n"
                                                    "how you can get good salary package job. We do your\n"
                                                    "intensive counselling and suggest you one skill and\n"
                                                    "based on it, professional resume will be created by\n"
                                                    "our experts across various domains. We check your\n"
                                                    "communication and interview skill and suggest how\n"
                                                    "you can enhance them and otherthings needed to be\n"
                                                    "done to get closer to your dream job. By the end you\n"
                                                    "will have you Dream job with a good salary package.",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Text("Enroll Now"),
                    // ),
                    // Container(
                    // height: 38,
                    // width: 100,
                    // // color: Colors.purple,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(7),
                    //     color: Colors.purple,
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: Colors.black,
                    //         offset: Offset(2, 5),
                    //         blurRadius: 10,
                    //       ),
                    //     ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          ExpansionPanelList(
                            expansionCallback: ((panelIndex, isExpanded) {
                              active = !active;
                              setState(() {});
                            }),
                            children: [
                              ExpansionPanel(
                                backgroundColor:
                                    const Color.fromARGB(255, 236, 233, 233),
                                headerBuilder: (context, isExpanded) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                      // height: 38,
                                      // width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        // color: Colors.purple,
                                        // boxShadow: const [
                                        //   BoxShadow(
                                        //     color: Colors.black,
                                        //     offset: Offset(2, 5),
                                        //     blurRadius: 10,
                                        //   )
                                        // ]
                                      ),
                                      child: const Center(
                                          child: Text("Enroll Now")),
                                    ),
                                  );
                                },
                                body: Form(
                                  key: _formKey,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    spacing: 7,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: nameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Valid Name';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: numberController,
                                          validator: (value) {
                                            if (value!.trim().length != 10) {
                                              return 'Enter 10 Digit Mobile Number';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "Mobile",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: emailController,
                                          validator: (value) {
                                            if (!value!.contains("@")) {
                                              return 'Enter Valid Email';
                                            }
                                            return null;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: qualifyController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can't be empty";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            hintText: "Qualification",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: locationController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can't be empty";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            hintText: "Location",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              final form = _formKey
                                                  .currentState!
                                                  .validate();
                                              if (form) {
                                                _submitForm();
                                              }
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isExpanded: active,
                                canTapOnHeader: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite_rounded,
                size: 56,
                color: Colors.red[400],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("Notification")
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot questions =
                              snapshots.data!.docs[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(MyRoutes.topics);
                                },
                                child: Card(
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(20.0),
                                  // ),
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          height: 60,
                                          width: 40,
                                          child: CircleAvatar(
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/notifyImg.jpg'),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  questions['head'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                questions['body'],
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Center(
                      child: Text("profile pic"),
                    ),
                  ),
                  Text("resumes"),
                  Text("data"),
                  InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().whenComplete(
                              () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const FirstScreen()),
                              ),
                            );

                        //  FirebaseAuth.instance.signOut().then()=>Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (context) => const FirstScreen()),
                        //       );
                      },
                      child: Text("Sign out")),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          bottomPadding: 8,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.favorite_rounded,
                outlinedIcon: Icons.favorite_border_rounded),
            BarItem(
              filledIcon: Icons.notifications_rounded,
              outlinedIcon: Icons.notifications_outlined,
            ),
            BarItem(
              filledIcon: Icons.supervised_user_circle_rounded,
              outlinedIcon: Icons.supervised_user_circle_outlined,
            ),
          ],
        ),
      ),
    );
  }
}


// GridView.extent(
//                         maxCrossAxisExtent: 200,
//                         primary: false,
//                         padding: const EdgeInsets.all(10),
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height / 6,
//                             color: Colors.black,
//                             child: Text("Core Java"),
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.height / 6,
//                             color: Colors.black,
//                             child: Text("Advance Java"),
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.height / 6,
//                             color: Colors.black,
//                             child: Text("Resume Builder"),
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.height / 6,
//                             color: Colors.black,
//                             child: Text("Interview Questions"),
//                           )
//                         ],
//                       ),

//  appBar: AppBar(
//     title: const Text("Java 7 Days Challenge"),
//     actions: [
//       Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: IconButton(
//           icon: const Icon(Icons.notifications),
//           onPressed: () {
//             Navigator.of(context).pushNamed(MyRoutes.notification);
//           },
//         ),
//       ),
//     ],
//   ),
//   drawer: Drawer(
//     backgroundColor: Colors.white,
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         UserAccountsDrawerHeader(
//           accountName: Text((() {
//             if (user.displayName != null) {
//               return user.displayName!;
//             } else {
//               return name;
//             }
//           })()),
//           accountEmail: Text(user.email!),
//           currentAccountPicture: Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(100),
//               color: Colors.white12,
//               image: DecorationImage(
//                 image: NetworkImage((() {
//                   if (user.photoURL != null) {
//                     return user.photoURL!;
//                   }
//                   return 'assets/images/blue-wallpaper-3.jpg';
//                 })()),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         ListTile(
//           leading: const Icon(Icons.person),
//           title: const Text("Profile"),
//           onTap: () {},
//         ),
//         ListTile(
//           leading: const Icon(Icons.file_copy_rounded),
//           title: const Text("Create resume"),
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => const ResumeFormPage()));
//             // Navigator.of(context).pushNamed(MyRoutes.resumeform);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.computer_outlined),
//           title: const Text("Courses"),
//           onTap: () {
//             Navigator.of(context).pushNamed(MyRoutes.courses);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.question_answer_outlined),
//           title: const Text("Question and Answer"),
//           onTap: () {
//             Navigator.of(context).pushNamed(MyRoutes.topics);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.contact_mail),
//           title: const Text("Contact us"),
//           onTap: () {
//             // Navigator.of(context).pushNamed(MyRoutes.contactUs);
//             showGeneralDialog(
//                 context: context,
//                 barrierColor: Colors.black.withOpacity(0.5),
//                 transitionBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   final curvedValue =
//                       Curves.easeInOutBack.transform(animation.value) - 1.0;
//                   return Transform(
//                     transform: Matrix4.translationValues(
//                         0.0, curvedValue * 200, 0.0),
//                     child: Opacity(
//                       opacity: animation.value,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 70),
//                         child: AlertDialog(
//                           shape: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           title: const Text("Feedback"),
//                           content: Column(
//                             children: [
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(10),
//                                     ),
//                                     hintText: "Enter your Email"),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 transitionDuration: const Duration(milliseconds: 200),
//                 barrierDismissible: true,
//                 barrierLabel: '',
//                 pageBuilder: (context, animation1, annimation2) {
//                   return Column();
//                 });
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.settings),
//           title: const Text("Settings"),
//           onTap: () {},
//         ),
    //     ListTile(
    //       title: const Text("Sign out"),
    //       onTap: () async {
    //         // google logout method
    //         // final provider =
    //         //     Provider.of<GoogleSignInProvider>(context, listen: false);
    //         // provider.logout();
    //         // AuthController.instance.logOut();
    //         // Navigator.of(context).pushAndRemoveUntil(
    //         //   MaterialPageRoute(
    //         //     builder: (BuildContext) => FirstScreen(),
    //         //   ),
    //         //   (Route route) => false,
    //         // );
    //         await FirebaseAuth.instance.signOut().whenComplete(
    //               () => Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(
    //                     builder: (context) => const FirstScreen()),
    //               ),
    //             );
    //       },
    //     ),
    //   ],
    // ),
//   ),
