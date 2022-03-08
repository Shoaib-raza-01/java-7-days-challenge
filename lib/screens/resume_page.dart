import 'package:flutter/material.dart';

class ResumeFormPage extends StatefulWidget {
  const ResumeFormPage({Key? key}) : super(key: key);

  @override
  State<ResumeFormPage> createState() => _ResumeFormPageState();
}

class _ResumeFormPageState extends State<ResumeFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Build Your Resume"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:9.0),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width/2)-20,
                    child: TextFormField(
                      
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width/2)-20,
                  child: TextFormField(
                    
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
