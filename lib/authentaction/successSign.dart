import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SuccessSign  extends StatelessWidget{
  const SuccessSign ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Success",style: TextStyle(color: Colors.grey.shade600,fontSize: 25)),
          leading: Icon(Icons.check_box_outlined,size: 33,color: Colors.redAccent.shade700),
          backgroundColor: Colors.grey.shade50,
          shadowColor: Colors.teal.shade900,
          elevation: 600,),
        body :Container(
          padding: const EdgeInsets.only(top: 100,right: 10),
          child: Column(
            children: [
              Center(child: Icon(Icons.check_circle_outline_rounded,size: 150,color: Colors.redAccent.shade700,)),
              SizedBox(height: 5,),
              Text(" You have an account now !",style: TextStyle(fontSize: 20,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(left: 110,right: 110,top: 30),
                  child: ElevatedButton (
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 5),backgroundColor: Colors.redAccent.shade700,),
                    onPressed: (){Get.offAllNamed("/login");},
                    child: Text("Ok" , style: TextStyle(fontSize: 27,color: Colors.white),),),
                ),
              )
            ],
          ),
        )
    );
  }}