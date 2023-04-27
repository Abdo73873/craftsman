
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserHelpCon.dart';

class Button extends GetView<boarding>{
  const Button ({Key ? key}) : super (key: key);

  @override
  Widget build (BuildContext context)
  {
    return  Row(
      children: [

        Container(
            width: 80,
            margin: const EdgeInsets.only(bottom: 30,left: 305),
            child: IconButton(icon: Icon(Icons.navigate_next,size: 60,color: Colors.cyan.shade800,),
              onPressed: () {
                controller.next();
              },)
        ),

      ],
    );
  }
}