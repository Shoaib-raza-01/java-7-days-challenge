import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsdc/main.dart';
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
        title: const Text("Dashboard"),
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
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(user.email!),
              currentAccountPicture: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    // image: NetworkImage(user.photoURL!),
                    image: AssetImage('assets/images/blue-wallpaper-3.jpg'),
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
              onTap: () {},
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
                Navigator.of(context).pushNamed(MyRoutes.contactUs);
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
}
