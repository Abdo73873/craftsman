

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/main.dart';
import '../constant/constant.dart';
import '../models/person.dart';

Future<void> getMyData() async {
  if(myModel==null) {
    String role=shared!.getString('role')!;
    String to="craftsman";
    if(role=="user"){
      to="user";
    }
   await FirebaseFirestore.instance.collection(to)
    .doc(myId)
      .get()
      .then((my) {
      myModel =Person.fromJson(my.data()!);
  });
    FirebaseFirestore.instance.collection(to)
    .doc(myId)
    .update({"deviceToken":deviceToken});
  }

}
