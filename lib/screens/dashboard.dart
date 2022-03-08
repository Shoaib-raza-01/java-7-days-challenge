import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsdc/main.dart';
import 'package:jsdc/screens/resume_page.dart';
import 'package:jsdc/util/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String name = "User";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Java 7 Days Challenge"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).pushNamed(MyRoutes.notification);
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text((() {
                if (user.displayName != null) {
                  return user.displayName!;
                } else {
                  return name;
                }
              })()),
              accountEmail: Text(user.email!),
              currentAccountPicture: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white12,
                  image: DecorationImage(
                    image: NetworkImage((() {
                      if (user.photoURL != null) {
                        return user.photoURL!;
                      }
                      return 'assets/images/blue-wallpaper-3.jpg';
                    })()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.file_copy_rounded),
              title: const Text("Create resume"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResumeFormPage()));
                // Navigator.of(context).pushNamed(MyRoutes.resumeform);
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer_outlined),
              title: const Text("Courses"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text("Question and Answer"),
              onTap: () {
                Navigator.of(context).pushNamed(MyRoutes.topics);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact us"),
              onTap: () {
                // Navigator.of(context).pushNamed(MyRoutes.contactUs);
                showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final curvedValue =
                          Curves.easeInOutBack.transform(animation.value) - 1.0;
                      return Transform(
                        transform: Matrix4.translationValues(
                            0.0, curvedValue * 200, 0.0),
                        child: Opacity(
                          opacity: animation.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: AlertDialog(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: const Text("Feedback"),
                              content: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "Enter your Email"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                    barrierLabel: '',
                    pageBuilder: (context, animation1, annimation2) {
                      return Column();
                    });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Sign out"),
              onTap: () async {
                // google logout method
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                // AuthController.instance.logOut();
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //     builder: (BuildContext) => FirstScreen(),
                //   ),
                //   (Route route) => false,
                // );
                await FirebaseAuth.instance.signOut().whenComplete(
                      () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const FirstScreen()),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  // AccName() {
  //   if(user.displayName != null){

  //   }
  // }
}
