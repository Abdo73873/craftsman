

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/main.dart';

import '../constant/constant.dart';
import '../models/person.dart';

void getMyData() {
  if(myModel==null) {
    String role=shared!.getString('role')!;
    FirebaseFirestore.instance.collection(role)
    .doc(myId)
      .get()
      .then((my) {
      myModel =Person.fromJson(my.data()!);
  });
  }

}
