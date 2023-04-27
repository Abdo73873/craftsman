
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserHelpCon.dart';
import 'boardingList.dart';

class pageView extends GetView<boarding>{
  const pageView ({Key ? key}) : super (key: key);

  @override
  Widget build (BuildContext context)
  {
    return  PageView.builder(
      controller: controller.nextPage,
      onPageChanged: (val){
        controller.DotChanged(val);
      },
      itemCount: BoardingList.length,
      itemBuilder: (context , i )=> Column(
        children: [
          const SizedBox(height: 70,),
          Image.asset(BoardingList[i].image!),
          const SizedBox(height: 40,),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text (BoardingList[i].Text!, textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1)),

        ],
      ),

    );

  }
}