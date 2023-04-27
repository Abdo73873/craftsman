
import 'dart:convert';

import 'package:http/http.dart' as http;


Future<void> sendNotify({
  required String to,
  required String title,
  required String message,
   String? userId,
   String? name,
   String? image,
})async{

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "key=AAAAXKlqos0:APA91bFQ2HP0yWiIwGs96W4F-s-0Q-RQ7rZ7FWGA_veFkzURM9S5FuglOwN6XWJ9tNG2mrWvfWY424rFltsTp6XCa2YfOjspGXenfJafuxdP4n6YbfbnDMEffTMPNqyHxwLBrjWTIrqU",
    },
      body: jsonEncode({
        "to":to,
        "notification":{
          "title":title,
          "body":message,
          "sound":"defualt"

        },
        "android":{
          "priority":"HIGH",
          "notification":{
            "notification_priority":"priority_MAX",
            "sound":"defualt",
            "defualt_sound":"true",
            "defualt_vibrate_timings":"true",
            "defualt_ligt_settings":"true"

          }

        },
        "data":{
      "click_action":"FLUTTER_NOTIFICATOIN_CLICK",
      "type":"order",
          "id":userId,
          "name":name,
          "image":image,
        }
      }),
    );
    print('FCM request for device sent!');


}

