import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/profile/profile.dart';
import 'package:craftsman/profile/viewProfile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main.dart';

class Painter extends StatefulWidget {

  Painter({Key? key}) : super(key: key);

  @override
  PainterState createState() => PainterState();
}
class PainterState extends State<Painter>{

  CollectionReference Painters = FirebaseFirestore.instance.collection("Painters");


  getUser(){
    var user = FirebaseAuth.instance.currentUser;
  }


  @override
  void initState(){
    getUser();

    super.initState();
  }


  @override
  Widget build (BuildContext context)

  {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF89dad0),
        title: Text("Painters",style: TextStyle(color: Colors.red.shade800),),
        centerTitle: true,
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.red.shade800,),onPressed: (){

        }) ,
      ),

      body : Container(
          child: FutureBuilder(
              future: Painters.get(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return PaintersList(
                            painter : snapshot.data.docs[i],
                            id: snapshot.data.docs[i].id);
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );

  }
}
class PaintersList extends StatelessWidget{
  final painter;
  final id;
  PaintersList({super.key,
    this.painter, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  @override
  Widget build (BuildContext context){
    final TextEditingController _messageController = TextEditingController();
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return view(crafts: painter,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("\n${painter['FirstName']}",),
                subtitle: Text("\n${painter['Career']}"),
                textColor:Colors.orange.shade900 ,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text("\n${painter['phone']}",),
                textColor:Colors.orange.shade900 ,

              ),
            ),


            Expanded(
                flex: 2,
                child: ListTile(

                  trailing:
                      ElevatedButton(
                        child: Text('Send Request'),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('Painters').doc(id).collection("request").add({
                            'Email': FirebaseAuth.instance.currentUser!.email,
                            'userId': FirebaseAuth.instance.currentUser!.uid,
                            'status': 'pending',
                          });
                          // Send request to Firebase
                        },
                      ),

                )
            ),

          ],
        ),

      ),
    );

}

}

