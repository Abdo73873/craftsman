import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/main.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Carpenter extends StatefulWidget {

  Carpenter({Key? key}) : super(key: key);

  @override
  CarpenterState createState() => CarpenterState();
}
class CarpenterState extends State<Carpenter>{

  CollectionReference carpenters = FirebaseFirestore.instance.collection("Carpenters");


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
        title: Text("Carpenters",style: TextStyle(color: Colors.red.shade800),),
        centerTitle: true,
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.red.shade800,),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : Container(
          child: FutureBuilder(
              future: carpenters.get(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return CarpenterList(
                            carpenter : snapshot.data.docs[i],
                            id: snapshot.data.docs[i].id);
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );

  }
}
class CarpenterList extends StatelessWidget{
  final carpenter;
  final id;
  CarpenterList({super.key,
    this.carpenter, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build (BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return view(crafts: carpenter,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("\n${carpenter['FirstName']}",),
                subtitle: Text("\n${carpenter['Career']}"),
                textColor:Colors.orange.shade900 ,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text("\n${carpenter['phone']}",),
                textColor:Colors.orange.shade900 ,

              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                  trailing:  IconButton(
                    color: Colors.teal.shade800, onPressed: () {

                  }, icon: Icon(Icons.add),),
                  )
              ),
          ],
        ),
      ),
    );

  }

}
