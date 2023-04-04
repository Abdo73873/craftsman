
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile  extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState ()=> ProfileState();
}
  class ProfileState extends State<Profile>{
  String? name ='';
  String? email ='';
  String? age ='';
  String? address ='';
  String? phone ='';
  String? career ='';
  //String image='';
  //File? imageFile;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
           Navigator.of(context).pop();
          },icon: const Icon(Icons.arrow_back_ios_new),),
          title: const Text("Profile"),
          backgroundColor: Colors.cyan.shade800,
        ),
        body: Stack (
          children: [
            SafeArea(child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Expanded(
                    child:ListView(
                      children:[
                        const SizedBox(height: 35,),
                       /* GestureDetector(
                          onTap: (){},
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: imageFile==null?
                              AssetImage(image):
                              Image.file(imageFile!).image
                            ),
                          ),
                        ),*/

                        const SizedBox(height: 35,),
                        ListTile(
                          onTap: (){
                            Get.off("");
                          },
                          leading:  Icon(Icons.person,color: Colors.cyan.shade500,size: 20),
                          title:  Text ("User Name : " + "$name",style: const TextStyle(fontSize: 19)),

                        ),

                        const SizedBox(height: 35),
                        ListTile(
                          onTap: (){
                            Get.off("");
                          },
                          leading:  Icon(Icons.email,color: Colors.cyan.shade500,size: 20),
                          title:  Text ("Email : " + "\n$email",style: const TextStyle(fontSize: 19)),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        const SizedBox(height: 35),
                        ListTile(
                          onTap: (){
                            Get.off("");
                          },
                          leading:  Icon(Icons.phone,color: Colors.cyan.shade500,size: 20),
                          title:  Text ("Phone : " + "$phone",style: const TextStyle(fontSize: 19)),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        const SizedBox(height: 35),
                        ListTile(
                          onTap: (){
                            Get.off("");
                          },
                          leading:  Icon(Icons.text_snippet_sharp,color: Colors.cyan.shade500,size: 20),
                          title:  Text ("Age: " + "$age",style: const TextStyle(fontSize: 19)),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        const SizedBox(height: 35),
                        ListTile(
                          onTap: (){
                            Get.off("");
                          },
                          leading:  Icon(Icons.home_rounded,color: Colors.cyan.shade500,size: 20),
                          title:  Text ("Address: " + "$address",style: const TextStyle(fontSize: 19)),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        const SizedBox(height: 35),
                        ListTile(
                          onTap: () {
                            Get.off("");
                          },
                          leading:  Icon(Icons.person, color: Colors.cyan.shade500, size: 20),
                          title: Text("Career : " + "$career", style: const TextStyle(fontSize: 19)),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                ]))
              ],),
            )
            )],
        )
    );

  }


  Future getData()async{
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          //image = snapshot.data()!["image"];
        });
      }
    } );
    await FirebaseFirestore.instance.collection("Carpenters")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          career = snapshot.data()!["Career"];
         // image = snapshot.data()!["image"];
        });
      }
    } );
    await FirebaseFirestore.instance.collection("Plumpers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          career = snapshot.data()!["Career"];
          // image = snapshot.data()!["image"];
        });
      }
    } );
    await FirebaseFirestore.instance.collection("Electricals")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          career = snapshot.data()!["Career"];
          // image = snapshot.data()!["image"];
        });
      }
    } );
    await FirebaseFirestore.instance.collection("Painters")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          career = snapshot.data()!["Career"];
          // image = snapshot.data()!["image"];
        });
      }
    } );
    await FirebaseFirestore.instance.collection("Technicians")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if(snapshot.exists){
        setState(() {
          name = snapshot.data()!["UserName"];
          email = snapshot.data()!["email"];
          age = snapshot.data()!["age"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          career = snapshot.data()!["Career"];
          // image = snapshot.data()!["image"];
        });
      }
    } );
  }

  @override
  void initState(){
    super.initState();
    getData();

  }
}
