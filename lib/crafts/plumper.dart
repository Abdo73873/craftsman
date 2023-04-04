import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Plumper extends StatefulWidget {

  Plumper({Key? key}) : super(key: key);

  @override
  PlumperState createState() => PlumperState();
}
class PlumperState extends State<Plumper>{

  CollectionReference Plumpers = FirebaseFirestore.instance.collection("Plumpers");


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
        title: Text("Plumpers",style: TextStyle(color: Colors.red.shade800),),
        centerTitle: true,
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.red.shade800,),onPressed: (){

        }) ,
      ),

      body : Container(
          child: FutureBuilder(
              future: Plumpers.get(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return PlumpersList(
                            plumper : snapshot.data.docs[i],
                            id: snapshot.data.docs[i].id);
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );

  }
}
class PlumpersList extends StatelessWidget{
  final plumper;
  final id;
  PlumpersList({super.key,
    this.plumper, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  @override
  Widget build (BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return view(crafts: plumper,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("\n${plumper['UserName']}",),
                subtitle: Text("\n${plumper['Career']}"),
                textColor:Colors.orange.shade900 ,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text("\n${plumper['phone']}",),
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