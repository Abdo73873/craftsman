import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [


          SizedBox(height: 620,),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),
              labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
              suffixIcon:IconButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('Painters')
                      .doc(FirebaseAuth.instance.currentUser!.uid).collection('chats').add({
                    'message': _messageController.text,
                  });
                }, icon: Icon(Icons.send),
              ),
              hintText: ' Message',
            ),
          ),
        ],
      ),
    );
  }
}