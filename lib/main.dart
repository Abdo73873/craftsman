
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/standared/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification/notification_screen.dart';

late final SharedPreferences? shared;

void requestPermissions()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  //notification
  deviceToken=await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen(firebaseMessaging);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  requestPermissions();
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