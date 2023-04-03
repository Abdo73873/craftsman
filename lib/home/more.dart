import 'dart:io';
import 'package:craftsman/main.dart';
import 'package:craftsman/authentaction/register.dart';
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
        backgroundColor: Colors.red,
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
                    leading: const Icon(Icons.home,color: Colors.redAccent,size: 40),
                    title: const Text ("Home",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/homepage");
                    },
                    leading: const Icon(Icons.message,color: Colors.redAccent,size: 40),
                    title: const Text ("Messages",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed("/setting");
                    },
                    leading: const Icon(Icons.settings,color: Colors.redAccent,size: 40),
                    title: const Text ("Settings",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed("/help");
                    },
                    leading: const Icon(Icons.help,color: Colors.redAccent,size: 40),
                    title: const Text ("Help",style: TextStyle(fontSize: 20)),
                  ),

                  const SizedBox(height: 25),

                  ListTile(
                    onTap: () async {
                      shared!.clear();
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed("/login");
                    },

                    leading: const Icon(Icons.exit_to_app,color: Colors.redAccent,size: 40,),
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