

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class view extends StatefulWidget{

  final crafts;
  view ({Key? key, this.crafts}) : super (key: key);

  @override
  viewproduct createState() => viewproduct();
}

class viewproduct extends State<view>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Craftsman Profile"),
        leading: IconButton(icon:Icon (Icons.arrow_back,color: Colors.white,),onPressed: (){
          Navigator.of(context).pop();
        }) ,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),

            Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text("Career : ${widget.crafts['role']}",style: const TextStyle(fontSize: 25),)),
            Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text("Phone : ${widget.crafts['phone']}",style: const TextStyle(fontSize: 25),)),


          ],),
      ),
    );
  }
}