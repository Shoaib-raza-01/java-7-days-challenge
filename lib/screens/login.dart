import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2.4,
              width: MediaQuery.of(context).size.height/3,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  
                  image: AssetImage('assets/images/google.png', )
                ),
              ),
            ),
            Container(
              child: Form(
                child:Padding(
                  padding:const  EdgeInsets.only(top: 5.0 , bottom: 15.0 , left: 10,right: 10.0),
                  child: Card(
                    // color: Colors.amber[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Java 7 Days Challenge", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                          child: TextFormField(
                            style:const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            decoration:const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15),
                                ),
                              ),
                              icon: Icon(Icons.email),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                          child: TextFormField(
                            obscureText: !_showPassword,
                            style:const TextStyle(
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
                                      _showPassword ? Icons.visibility : Icons
                                          .visibility_off, color: Colors.grey,
                                    ),
                                  ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15),
                                ),
                              ),
                              icon: const Icon(Icons.lock),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15)
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            height: MediaQuery.of(context).size.height/18,
                            margin:const EdgeInsets.only(top: 25,bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child:const Center(
                              child: Text("Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async{},
                        ),
                      ],
                    ),
                  ),
                ), 
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}