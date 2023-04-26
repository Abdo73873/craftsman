
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constant/app_color.dart';
import 'Dot.dart';
import 'UserHelpCon.dart';
import 'boardingButton.dart';
import 'pageView.dart';

class UserHelp extends StatelessWidget{
  const UserHelp ({Key ? key}) : super(key: key);
  @override

  Widget build (BuildContext context){
    Get.put(boarding());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).pushReplacementNamed("/more");
        }, icon: const Icon(Icons.arrow_back_ios_new),),
        title: const Text("Help"),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
             const Expanded(
              flex: 3,
              child: pageView(),
            ) ,
            Expanded(
                flex: 1,
                child: Column(children:const [
                  SizedBox(height: 70,),
                  Dot(),
                  Spacer(flex: 5,),
                  Button(),
                ],))
          ],
        ),
      ),
    );
  }
}

