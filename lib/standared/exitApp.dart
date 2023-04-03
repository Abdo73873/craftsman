import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future <bool> ExitApp(){
  Get.defaultDialog(
      title: "Warning !",
      middleText: "Do you want to exit from app ?",
      actions: [
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            onPressed: (){
              exit(0);},
            child: const Text("Yes",style: TextStyle(color: Colors.black),)),
        const SizedBox(width: 20,),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            onPressed: (){
              Get.back();
            }, child: const Text("Cancel",style: TextStyle(color: Colors.black),)),
      ]
  );
  return Future.value(true);
}