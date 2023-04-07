
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/home/home.dart';
import 'package:craftsman/standared/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences? shared;

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  myId=shared!.getString('myId');
  runApp( const MainPage());
}

class MainPage  extends StatelessWidget{
  const MainPage({Key ? key}) : super (key: key);

  @override
  Widget build(BuildContext context)
  {

    //locale control =  Get.put(locale());
    return GetMaterialApp(
      //translations : language(),
      debugShowCheckedModeBanner: false,
     // locale: control.language,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,color: Colors.red.shade900),
          bodyText1: TextStyle(height: 2,fontSize: 17,color: Colors.grey.shade700),
        ) ,
        primaryColor: Colors.red,
      ),
      getPages: routes,

    );
  }
}