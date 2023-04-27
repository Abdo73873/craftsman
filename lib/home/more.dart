
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/main.dart';
import 'package:craftsman/notification/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class More extends StatelessWidget{

  More({Key ? key}) : super (key : key);


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: Stack (children: [
        SafeArea(child: Container(
          width: 300,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(child: ListView(
                children: [
                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/homepage");
                    },
                    leading:  Icon(Icons.home,color: AppColors.primary,size: 40),
                    title: const Text ("Home",style: TextStyle(fontSize: 20)),
                  ),
                  if(myModel!=null &&myModel!.role!="user")
                  const SizedBox(height: 25),
                  if(myModel!=null &&myModel!.role!="user")
                    ListTile(
                    onTap: (){
                      Get.offAllNamed("/RequestsScreen3");
                    },
                    leading:  Icon(Icons.request_page,color: AppColors.primary,size: 40),
                    title: const Text ("Requests",style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 25),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/setting");
                    },
                    leading:  Icon(Icons.settings,color: AppColors.primary,size: 40),
                    title: const Text ("Settings",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/Userhelp");
                    },
                    leading:  Icon(Icons.help,color: AppColors.primary,size: 40),
                    title: const Text ("Help",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: () async {
                      shared!.clear();

                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed("/login");
                    },

                    leading:  Icon(Icons.exit_to_app,color: AppColors.primary,size: 40,),
                    title: const Text ("Log out",style: TextStyle(fontSize: 20)),
                  ),
                ],
              ))
            ],
          ),
        )
        )],
      ),
    );
  }
}