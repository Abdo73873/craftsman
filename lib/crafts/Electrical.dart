import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Electrical extends StatefulWidget {

  Electrical({Key? key}) : super(key: key);

  @override
  ElectricalState createState() => ElectricalState();
}
class ElectricalState extends State<Electrical>{

  CollectionReference Electricals = FirebaseFirestore.instance.collection("electricals");


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
        title: Text("Electricals",style: TextStyle(color: Colors.red.shade800),),
        centerTitle: true,
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.red.shade800,),onPressed: (){

        }) ,
      ),

      body : Container(
          child: FutureBuilder(
              future: Electricals.get(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return ElectricalList(
                            electrical : snapshot.data.docs[i],
                            id: snapshot.data.docs[i].id);
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );

  }
}
class ElectricalList extends StatelessWidget{
  final electrical;
  final id;
  ElectricalList({super.key,
    this.electrical, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  @override
  Widget build (BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return view(crafts: electrical,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("\n${electrical['UserName']}",),
                subtitle: Text("\n${electrical['Career']}"),
                textColor:Colors.orange.shade900 ,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text("\n${electrical['phone']}",),
                textColor:Colors.orange.shade900 ,

              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  trailing:  Icon(Icons.edit,color: Colors.teal.shade800,),
                )
            ),
          ],
        ),
      ),
    );
  }
}