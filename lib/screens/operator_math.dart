import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class OperatorPage  extends StatelessWidget {
  const OperatorPage ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text("Operators & Math"),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("operatorMath").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot questions = snapshots.data!.docs[index];
                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Text(
                                  questions['ques'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Text(questions['ans']),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () {
                                        showGeneralDialog(
                                            context: context,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            transitionBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              final curvedValue = Curves
                                                      .easeInOutBack
                                                      .transform(
                                                          animation.value) -
                                                  1.0;
                                              return Transform(
                                                transform:
                                                    Matrix4.translationValues(
                                                        0.0,
                                                        curvedValue * 200,
                                                        0.0),
                                                child: Opacity(
                                                  opacity: animation.value,
                                                  child: AlertDialog(
                                                    shape: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    title: const Text(
                                                        "Detailed Explanation"),
                                                    content: Text(
                                                        questions['details']),
                                                  ),
                                                ),
                                              );
                                            },
                                            transitionDuration:
                                                Duration(milliseconds: 200),
                                            barrierDismissible: true,
                                            barrierLabel: '',
                                            pageBuilder: (context, animation1,
                                                annimation2) {
                                              return Column();
                                            });
                                      },
                                      child: const Text("View Answer")),
                                )
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
    );
  }
}
