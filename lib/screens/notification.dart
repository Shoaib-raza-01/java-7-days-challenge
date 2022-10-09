import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jsdc/main.dart';
import 'package:jsdc/util/routes.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //***********for sending notification to users*********
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection("Notification").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot questions = snapshots.data!.docs[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(MyRoutes.dashboard);
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
                                  width:
                                      MediaQuery.of(context).size.width - 100,
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
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Notifications"),
  //     ),
  //     body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  //       stream:
  //           FirebaseFirestore.instance.collection("Notification").snapshots(),
  //       builder: (context, snapshots) {
  //         if (snapshots.hasData) {
  //           return ListView.separated(
  //               itemCount: snapshots.data!.docs.length,
  //               separatorBuilder: (context, index) {
  //                 return const Divider(
  //                   height: 0,
  //                 );
  //               },
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot questions = snapshots.data!.docs[index];
  //                 return ListView(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children:  [
  //                         SizedBox(
  //                           height: 30,
  //                           width: MediaQuery.of(context).size.width/4.5,
  //                           child:const CircleAvatar(
  //                             child: Image(
  //                               image: AssetImage('assets/images/notifyImg.jpg'),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 30,
  //                           width: MediaQuery.of(context).size.width/4.5
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 );
  //               });
  //         }
  //         else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     ),
  //   );
  // }
}
