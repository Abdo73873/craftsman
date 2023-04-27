

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/home/craftHome.dart';
import 'package:flutter/material.dart';



class RequestsScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
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
                subtitle: Text(document['userId']),
                trailing: ElevatedButton(
                  child: Text('Accept'),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('requests').doc(document.id).update({
                      'status': 'responded',
                    }).then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CraftHome()
                    ) ));
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
