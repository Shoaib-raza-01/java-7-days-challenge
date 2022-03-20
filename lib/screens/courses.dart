import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

class CoursesPage extends StatefulWidget {
  // final ValueChanged<Data> onSavedData;
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController qualifyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  late AnimationController _controller1;
  late Animation _animation1;
  late AnimationController _controller2;
  late Animation _animation2;
  AnimationStatus _status1 = AnimationStatus.dismissed;
  AnimationStatus _status2 = AnimationStatus.dismissed;
  bool active = false;
  bool rotate = false;

  @override
  void initState() {
    super.initState();
    _controller1 =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation1 = Tween(end: 1.0, begin: 0.0).animate(_controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status1 = status;
      });

    _controller2 =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation2 = Tween(end: 1.0, begin: 0.0).animate(_controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status2 = status;
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

  Future<void> _submitBookForm() async {
    try {
      await FirebaseFirestore.instance.collection("BOOK_FINISHER").add({
        'name': nameController.text,
        'email': emailController.text,
        'topic': topicController.text,
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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Courses"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Get Your Fortune Career",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromARGB(255, 75, 72, 72),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Join Us To Get Closer To Your Offer Letter",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
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
                              width: MediaQuery.of(context).size.width - 30,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color.fromARGB(255, 236, 233, 233),
                                shadowColor: Colors.black,
                                child: Stack(
                                  children: [
                                    Center(
                                        child: Image.asset(
                                            'assets/images/SA_LOGO.png')),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        "Contents",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 97, 94, 94),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 40,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                        padding: EdgeInsets.only(left: 40),
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
                                width: MediaQuery.of(context).size.width - 30,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 236, 233, 233),
                                  shadowColor: Colors.black,
                                  child: Stack(
                                    children: [
                                      Center(
                                          child: Image.asset(
                                              'assets/images/SA_LOGO.png')),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          "How this program will help you",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color:
                                                Color.fromARGB(255, 97, 94, 94),
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
                                      const Positioned(
                                        top: 40,
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            '''-  In this program “Get Your Fortune Career” we guide 
        how you can get good salary package job. We do your 
        intensive counselling and suggest you one skill and 
        based on it, professional resume will be created by 
        our experts across various domains. We check your 
        communication and interview skill and suggest how 
        you can enhance them and otherthings needed to be 
        done to get closer to your dream job. By the end you 
        will have you Dream job with a good salary package.''',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.justify,
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
                                child: const Center(child: Text("Enroll Now")),
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
                                    keyboardType: TextInputType.emailAddress,
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
                                        final form =
                                            _formKey.currentState!.validate();
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
                                            style:
                                                TextStyle(color: Colors.white),
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
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Book Finisher Challenge",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromARGB(255, 75, 72, 72),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Get your Book in just 3 weeks",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateY(pi * _animation2.value),
                child: SizedBox(
                  child: _animation2.value <= 0.5
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color.fromARGB(255, 236, 233, 233),
                                shadowColor: Colors.black,
                                child: Stack(
                                  children: [
                                    Center(
                                        child: Image.asset(
                                            'assets/images/SA_LOGO.png')),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        "Contents",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 97, 94, 94),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 40,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Identify the reason of book writing.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 60,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Identify the topic.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 80,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Reframe your thinking of writing a book.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 100,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Create the book outline or frame work.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 120,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Content creation guide and book cover design",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 140,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Menu script proof reading.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 160,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Get help in your book publication.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 180,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Promote your book in various platforms.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 200,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          "-  Get your book featured in YouTube Channels.",
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
                                          if (_status2 ==
                                              AnimationStatus.dismissed) {
                                            _controller2.forward();
                                          } else {
                                            _controller2.reverse();
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
                                width: MediaQuery.of(context).size.width - 30,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 236, 233, 233),
                                  shadowColor: Colors.black,
                                  child: Stack(
                                    children: [
                                      Center(
                                          child: Image.asset(
                                              'assets/images/SA_LOGO.png')),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          "About Book Finisher Challenge",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color:
                                                Color.fromARGB(255, 97, 94, 94),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        right: 15,
                                        child: InkWell(
                                          onTap: () {
                                            if (_status2 ==
                                                AnimationStatus.dismissed) {
                                              _controller2.forward();
                                            } else {
                                              _controller2.reverse();
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
                                          child: Text(
                                            '''-  This Book Finisher Challenge is a three week intensive program \nin which we will guide you step by step how \nyou can identify your topic , create book outline , \ncreate content and complete you book writing within time frame.''',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.justify,
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: Column(
                  children: [
                    ExpansionPanelList(
                      expansionCallback: ((panelIndex, isExpanded) {
                        rotate = !rotate;
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
                                child: const Center(child: Text("Enroll Now")),
                              ),
                            );
                          },
                          body: Form(
                            key: _formKey2,
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
                                        return "Field can't be empty";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
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
                                    keyboardType: TextInputType.emailAddress,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: topicController,
                                    decoration: InputDecoration(
                                      hintText: "Topic (If any)",
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
                                       final form2 =
                                            _formKey2.currentState!.validate();
                                        if (form2) {
                                          _submitBookForm();
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: rotate,
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
    );
  }
}
