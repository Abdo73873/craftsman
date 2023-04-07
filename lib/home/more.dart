import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/chats/cubit/chat_cubit.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


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
          width: 200,
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

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/homepage");
                    },
                    leading:  Icon(Icons.message,color: AppColors.primary,size: 40),
                    title: const Text ("Messages",style: TextStyle(fontSize: 20)),
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
                      Navigator.of(context).pushNamed("/help");
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