import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({ Key? key }) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Column(
        children: [
          const Text("Name",
          style: TextStyle
                  (color: Colors.black,
                  fontSize: 50,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Card(
                     shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                    child:const Text("Mohammad", 
                    style: TextStyle
                    (color: Colors.black,
                    fontSize: 50,
                    ),
                    ),
                  ),
                  Card(
                     shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                    child:const Text("Shoaib",
                    style: TextStyle
                    (color: Colors.black,
                    fontSize: 50,
                    ),
                    ),
                  ),
                  Card(
                     shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                    child:const Text("Raza",
                    style: TextStyle
                    (color: Colors.black,
                    fontSize: 50,
                    ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}