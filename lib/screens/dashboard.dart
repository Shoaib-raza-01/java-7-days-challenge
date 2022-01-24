import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jsdc/main.dart';
import 'package:jsdc/util/google_signin.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  
   const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName!),
              accountEmail: Text(user.email!),
              currentAccountPicture: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.file_copy_rounded),
              title: Text("Create resume"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.computer_outlined),
              title: Text("Courses"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("COntact us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Sign out"),
              onTap: () async {
                // google logout method
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                // AuthController.instance.logOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext) => FirstScreen(),
                  ),
                  (Route route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
