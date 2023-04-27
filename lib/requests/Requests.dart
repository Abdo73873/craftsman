//git add .
//git commit -m "add chat"
//git push -u origin main
//git pull origin main

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/notification/sen_notify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_color.dart';


class RequestsScreen3 extends StatefulWidget {
  const RequestsScreen3({super.key});

  @override
  State<RequestsScreen3> createState() => RequestsScreen3State();
}

class RequestsScreen3State extends State<RequestsScreen3> {
  var id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed("/homepage2");
          },),
        title: const Text('Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('craftsman')
            .doc(id)
            .collection('request')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document['Email']),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              CollectionReference edit = FirebaseFirestore
                                  .instance.collection('craftsman')
                                  .doc(id)
                                  .collection('request');
                              DocumentReference docref = edit.doc(document.id);
                              docref.get().then((value) =>
                                  FirebaseFirestore.instance.collection(
                                      'craftsman').doc(id).collection("persons")
                                      .doc(document['userId']).set({})
                                      .then((value) =>
                                      FirebaseFirestore.instance.collection(
                                          'user').doc(document['userId'])
                                          .collection("persons").doc(id).set({})
                                          .then((value) => docref.delete())))
                                  .then((value) {
                                    FirebaseFirestore.instance.collection('user')
                                    .doc(document["userId"]).get()
                                        .then((value){
                                      sendNotify(to: value["deviceToken"],
                                          title: "Accepted",
                                          message: "${myModel!.name} accepted your request",
                                          userId: myModel!.uId,
                                          name: myModel!.name,
                                          image: myModel!.image,);
                                    });

                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan.shade700,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                minimumSize:
                                Size(65, 25)),

                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: const Text('Accept'),
                          ),
                          const SizedBox(width: 20.0,),
                          OutlinedButton(
                            onPressed: () {
                              FirebaseFirestore
                                  .instance.collection('craftsman')
                                  .doc(id)
                                  .collection('request')
                              .doc(document.id)
                              .update({'status': 'rejected',}).then((value){
                                FirebaseFirestore.instance.collection('user')
                                    .doc(document["userId"]).get()
                                    .then((value){
                                  sendNotify(to: value["deviceToken"],
                                    title: "Reject",
                                    message: "${myModel!.name} reject your request",
                                    userId: myModel!.uId,
                                    name: myModel!.name,
                                    image: myModel!.image,);
                                }).then((value){
                                  FirebaseFirestore
                                      .instance.collection('craftsman')
                                      .doc(id)
                                      .collection('request')
                                      .doc(document.id).delete();
                                });

                              });
                            },
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.zero),
                              minimumSize: MaterialStatePropertyAll(
                                  Size(65, 20)),
                            ),
                            child: Text('Reject', style: TextStyle(
                                fontSize: 15, color: Colors.cyan.shade700),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              );
            }).toList(),
          );
        },
      ),
    );
  }

}