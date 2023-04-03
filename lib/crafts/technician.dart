import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Technician extends StatefulWidget {

  Technician({Key? key}) : super(key: key);

  @override
  TechnicianState createState() => TechnicianState();
}
class TechnicianState extends State<Technician>{

  CollectionReference Technicians = FirebaseFirestore.instance.collection("Technicians");


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
        title: Text("Technicians",style: TextStyle(color: Colors.red.shade800),),
        centerTitle: true,
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.red.shade800,),onPressed: (){

        }) ,
      ),

      body : Container(
          child: FutureBuilder(
              future: Technicians.get(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return TechniciansList(
                            Technician : snapshot.data.docs[i],
                            id: snapshot.data.docs[i].id);
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );

  }
}
class TechniciansList extends StatelessWidget{
  final Technician;
  final id;
  TechniciansList({super.key,
    this.Technician, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  @override
  Widget build (BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return view(crafts: Technician,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("\n${Technician['FirstName']}",),
                subtitle: Text("\n${Technician['Career']}"),
                textColor:Colors.orange.shade900 ,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text("\n${Technician['phone']}",),
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