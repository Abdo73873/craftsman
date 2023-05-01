
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../main.dart';
class middleware extends GetMiddleware{

  
  @override
  RouteSettings ? redirect(String?route) {
    if(shared!.getString("role") !=null && shared!.getString("role")=="user" ) {
      return const RouteSettings(name: "/homepage");
    } else if(shared!.getString("role") !=null && shared!.getString("role")=="craftsman" ) {
    return const RouteSettings(name: "/homepage2");
  }
    return null;
}
}