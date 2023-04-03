

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../request/userscreen.dart';


class RequestsScreen3 extends StatelessWidget {
  var id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Painters').doc(id).collection('request').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document['Email']),
                //subtitle: Text(document['userId']),
                trailing: ElevatedButton(
                  child: Text('Accept'),
                  onPressed: () {
                    CollectionReference edit = FirebaseFirestore.instance.collection('Painters').doc(id).collection('request');
                    DocumentReference docref = edit.doc(document.id);
                    docref.update({'status': 'responded',}).then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequestScreen())
                    )
                    );
                    // Respond to request
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

}