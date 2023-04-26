
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserHelpCon.dart';
import 'boardingList.dart';


class Dot extends StatelessWidget{
  const Dot ({Key ? key}) : super (key: key);

  @override
  Widget build (BuildContext context)
  {
    return GetBuilder<boarding>(
        builder: (controller) =>  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...List.generate(BoardingList.length,
                  (pageNumber) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),
                duration: const Duration(milliseconds: 300),
                width: controller.currentPage == pageNumber ? 12: 7,
                height: controller.currentPage == pageNumber ? 12: 7,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade800,
                  borderRadius: BorderRadius.circular(7),),))],
        ));

  }
}