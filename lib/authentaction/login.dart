import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:craftsman/home/Userhome.dart';
import 'package:craftsman/main.dart';
import 'package:craftsman/home/craftHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:craftsman/standared/images.dart';
import '../standared/exitApp.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  GlobalKey <FormState>formState =  GlobalKey <FormState>();
  var email,password;
  bool isObscure3 = true;
  bool visible = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop:ExitApp,
        child :Container(
        margin: const EdgeInsets.all(15),
        child: Form(
        key: formState,
        child: ListView(
            padding: const EdgeInsets.only(top: 50),
            children: [
              Image.asset(image.image8,height: 220,),
              const SizedBox(height: 27),
              //const Text(" Welcome back !",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                    filled: true,
                    labelText: 'Email',
                    enabled: true,
                    prefixIcon: Icon(Icons.email,color: Colors.cyan.shade800,),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.cyan.shade700, width: 2,)),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.cyan.shade500, width: 2,))),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  if (!RegExp(
                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  }},
                onSaved: (value) {
                  email = value;
                  },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20,),

              TextFormField(
                style: const TextStyle(color: Colors.black),
                obscureText: isObscure3,
                decoration: InputDecoration(
                    labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                    suffixIcon: IconButton(icon: Icon(isObscure3 ?Icons.visibility_off :Icons.visibility), onPressed: () {
                      setState(() {
                        isObscure3 = !isObscure3;});}),

                    prefixIcon: Icon(Icons.key,color: Colors.cyan.shade800),
                    filled: true,
                    enabled: true,
                    labelText: 'Password',

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.cyan.shade700, width: 2,)),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.cyan.shade500, width: 2,))),

                validator: (value) {
                  RegExp regex =  RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  if (!regex.hasMatch(value)) {
                    return ("please enter valid password min. 6 character");
                  }},
                onSaved: (value) {
                  password = value;
                  },
                keyboardType: TextInputType.emailAddress,),

              const SizedBox(height: 17,width: 50,),
              InkWell(
                  onTap: (){
                    Get.offAllNamed("/forget");
                    },
                  child:
                  const Text("   Forget Password ? ",textAlign: TextAlign.right,style: TextStyle(fontSize: 17,color: Colors.blueGrey),)),

              const SizedBox(height: 100,),

              Container(
                margin: const EdgeInsets.only(left: 110,right: 110,top: 30),
                child: ElevatedButton (
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 5),backgroundColor: Colors.cyan.shade800,),
                  onPressed: () async {
                    var user = await signIn();
                    if (user!= null) {
                      route();
                    }
                    setState(() {
                      visible = true;
                    });},
                  child: const Text("Login" , style: TextStyle(fontSize: 27,color: Colors.white),),),),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("       Not a member ?  ",style: TextStyle(color: Colors.black,fontSize: 18,),textAlign: TextAlign.center,),
                  InkWell(
                    onTap: (){
                      Get.offAllNamed("/register");
                      },
                    child: Text("Sign Up now",style: TextStyle(decoration:TextDecoration.underline,color: Colors.red.shade900,fontSize: 18,fontWeight: FontWeight.bold),),),

                  const SizedBox(height: 10,),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      )),],),])),),));}
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        if (documentSnapshot.get('role') == "User") {
          shared!.setString("role", "user");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>   const UserHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
    FirebaseFirestore.instance.collection('Carpenters')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Career') == "Carpenter") {
          shared!.setString("role", "craft");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const CraftHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });FirebaseFirestore.instance.collection('Plumpers')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Career') == "Plumper") {
          shared!.setString("role", "craft");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const CraftHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });FirebaseFirestore.instance.collection('Electricals')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Career') == "Electrical") {
          shared!.setString("role", "craft");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const CraftHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });FirebaseFirestore.instance.collection('Painters')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Career') == "Painter") {
          shared!.setString("role", "craft");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const CraftHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });FirebaseFirestore.instance.collection('Technicians')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('Career') == "Technician") {
          shared!.setString("role", "craft");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const CraftHome(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
  Future signIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.defaultDialog (
              title: " No user found for that email ! ",
              titleStyle: const TextStyle(color: Colors.blueGrey),
              middleTextStyle: const TextStyle(color: Colors.black),
              middleText: " Please try again! ",
              actions: [
                const SizedBox(width: 10,),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
                    onPressed: (){
                      Get.back();
                    }, child: const Text(" Ok ",style: TextStyle(color: Colors.black),)),]);}

        else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Please try again!',
              desc: 'Wrong password provided for that user',
              btnOkOnPress: () {},
              btnOkColor: Colors.redAccent
          ).show();  }}}}}

