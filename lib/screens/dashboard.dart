import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(8),
          children: [
            // UserAccountsDrawerHeader(
            //   accountName: Text(""),
            //   accountEmail: Text(""),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundColor: Colors.blue,
            //     child: Image.asset('assets/images/facebook.png'),
            //     ),
            //   ),
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
            // Container(
            //   height: MediaQuery.of(context).size.height/2.7,
            //   // width: 90,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(100),
            //     image:  DecorationImage(
            //       image: AssetImage('assets/images/logo.jpeg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Sign out"),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
