
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Career extends StatefulWidget{
  const Career({super.key});

  @override
  State <Career> createState()=> CareerState ();
}
class CareerState extends State<Career> {

  bool showProgress = false;




  final auth = FirebaseAuth.instance;
  var options = [
    'Carpenter',
    'Plumper',
    'Electrician',
    'Painter',
    'Maintenance technician',
  ];
  String role = 'Carpenter';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Career", style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 10, 70, 90),
        leading: IconButton(
            icon: const Icon (Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Get.offAllNamed("/register");
            }),
      ),
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(children: [
          const SizedBox(height: 30,),
          const Text(
            "Choose your career to complete the creation of your account ",
            style: TextStyle(color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),),
          const SizedBox(height: 40,),
          Column(
            children: [
              const Text(
                "Choose : ",
                style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),),
              const SizedBox(height: 20.0,),
              DropdownButton<String>(
                dropdownColor: Colors.cyan.shade600,
                isDense: true,
                isExpanded: false,
                iconEnabledColor: Colors.white,
                focusColor: Colors.white,
                items: options.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(
                      dropDownStringItem,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,),),);
                }).toList(),
                onChanged: (newValueSelected) {
                  print(role);
                  setState(() {
                    role = newValueSelected!;
                  });
                },
                value: role,
              ),
            ],),
          const Spacer(),
          MaterialButton(
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),
            elevation: 5.0,
            height: 40,
            onPressed: () {
              setState(() {
                showProgress = true;
              });
              postDetailsToFirestore();
            },
            color: Colors.redAccent.shade700,
            child: const Text(
              "Done", style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),),
        ],),),);
  }

  postDetailsToFirestore() async {
    /*FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    var Email= shared!.getString('email');
    var address =shared!.getString('address');
    var age = shared!.getString('age');
    var Fname = shared!.getString('UserName');
    var phone = shared!.getString('phone',);
    var id = shared!.getString('id');

*/

    myModel!.role = role;
    FirebaseFirestore.instance
        .collection('craftsman')
        .doc(myId)
        .set(myModel!.toMaP()).then((value) {
      Get.offAllNamed("/successSign");
    });
  }
}


