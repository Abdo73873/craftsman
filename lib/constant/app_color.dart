import 'package:craftsman/constant/constant.dart';
import 'package:flutter/material.dart';

class AppColors{
  static  Color primary=getPrimaryColor();

  static Color getPrimaryColor(){
    if(myModel!=null){
      if(myModel!.role=='user'){
        return Colors.cyan.shade800;
      }else{
        return Colors.red;
      }
    }else{
      return Colors.cyan.shade800;
    }
  }
}
