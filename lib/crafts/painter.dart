


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
  String? name ='';

  getUser() async{
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["FirstName"];

        });
      }
    } );
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
        backgroundColor:Colors.cyan.shade800,
        title: const Text("Choose a painter ",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(icon:const Icon (Icons.arrow_back,color: Colors.black,),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : FutureBuilder(
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
            return const Center(child: CircularProgressIndicator(),);
          }),
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

    return Column(
      children: [
        InkWell(
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
                    textColor:Colors.black ,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListTile(
                    subtitle: Text("\n${painter['phone']}",),
                    textColor:Colors.black ,

                  ),
                ),

                Expanded(
                    flex: 4,
                    child: ListTile(

                      trailing:
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade800,),
                            child: const Text('Send Request'),
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
        ),

      ],
    );

}

}

