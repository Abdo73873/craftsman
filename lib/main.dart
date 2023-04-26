
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/standared/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late final SharedPreferences? shared;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  _firebaseMessaging.requestPermission();
  _firebaseMessaging.getToken().then((token) {
    print(token);
  });
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings();
  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    },
  );
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