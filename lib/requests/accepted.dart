
//git add .
//git commit -m "add chat"
//git push -u origin main
//git pull origin main
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AcceptedRequests extends StatefulWidget {
  const AcceptedRequests({super.key});

  @override
  State<AcceptedRequests> createState ()=> AcceptedRequestsState();
}
class AcceptedRequestsState extends State<AcceptedRequests>{
  var id = FirebaseAuth.instance.currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        leading: IconButton(
          icon :const Icon(Icons.arrow_back),
          onPressed: () { Get.offAllNamed("/homepage2"); },),
        title: const Text('AcceptedRequests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Painters').doc(id).collection('AcceptedRequest').snapshots(),
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
                title: Text(document['Email']),);


            }).toList(),
          );
        },
      ),
    );
  }

}