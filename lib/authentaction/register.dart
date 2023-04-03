import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../standared/exitApp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  bool showProgress = false;
  bool visible = false;
  final formState = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController Fname = TextEditingController();
  final TextEditingController Lname = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  var career = "";
  bool isObscure = true;
  bool isObscure2 = true;
  File? file;
  late Reference ref;
  var currentItemSelected = "User";
  var role = "User" ,image;
  var options = [
    'User',
    'Craftsman',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:WillPopScope(
          onWillPop:ExitApp,
          child : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        child: Form(
                          key: formState,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 80,),
                              const Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40,),),
                              const SizedBox(height: 50,),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: Fname,
                                decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.person,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  if(value.length.isGreaterThan(20)){
                                    return " Can't be Greater Than 20";
                                  }
                                  if(value.length.isLowerThan(3)){
                                    return " Can't be Smaller Than 3";
                                  }
                                  else {return null;}
                                  },
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: Lname,
                                decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.person,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  if(value.length.isGreaterThan(20)){
                                    return " Can't be Greater Than 20";
                                  }
                                  if(value.length.isLowerThan(3)){
                                    return " Can't be Smaller Than 3";
                                  }
                                  else {return null;}
                                  },
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20,),

                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: Email,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.email,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                    return ("Please enter a valid email");
                                  }
                                  else {
                                    return null;
                                  }},
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: age,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Age',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.ad_units_sharp,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " Required";
                                  }
                                  if(value.length.isGreaterThan(2)){
                                    return " Can't be grater than 2";
                                  }
                                  else {
                                    return null;
                                  }},
                                onChanged: (value){},
                                keyboardType: TextInputType.number,
                              ),
                        const SizedBox(height: 20,),

                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: address,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Address',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.home,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  if(value.length.isLowerThan(5)){
                                    return " Can't be lower than 5";
                                  }
                                  if(value.length.isGreaterThan(50)){
                                    return " Can't be grater than 50";
                                  }
                                  else {
                                    return null;}},
                                onChanged: (value){},
                                keyboardType: TextInputType.text,),
                              const SizedBox(height: 20,),

                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: phone,
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: const TextStyle(fontSize: 17,color:Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.phone,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " Required";
                                  }
                                  if(value.length.isEqual(12)){
                                    return "Not Valid PhoneNumber ";
                                  }
                                  else {
                                    return null;
                                  }},
                                onChanged: (value){},
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 20,),

                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                obscureText: isObscure,
                                controller: password,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(isObscure
                                            ? Icons.visibility_off
                                            :Icons.visibility,color: Colors.white,),
                                        onPressed: () {
                                          setState(() {
                                            isObscure = !isObscure;
                                          });}),
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.key,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("please enter valid password min. 6 character");
                                  }
                                  else {return null;}},
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 20,),

                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                obscureText: isObscure2,
                                controller: confirmPass,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(isObscure2
                                            ? Icons.visibility_off
                                            : Icons.visibility,color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            isObscure2 = !isObscure2;});}),
                                    labelText: 'Confirm Password',
                                    labelStyle: const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                                    enabled: true,
                                    prefixIcon: Icon(Icons.key,color: Colors.red.shade500,),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),
                                validator: (value) {
                                  if (confirmPass.text != password.text) {
                                    return "Password did not match";
                                  } else {
                                    return null;
                                  }},
                                onChanged: (value) {},
                              ),

                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Choose : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),),
                                  DropdownButton<String>(
                                    dropdownColor: Colors.redAccent.shade700,
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
                                            fontSize: 20,),),);}).toList(),
                                    onChanged: (newValueSelected) {
                                      setState(() {
                                        currentItemSelected = newValueSelected!;
                                        role = newValueSelected;
                                      });
                                      },
                                    value: currentItemSelected,
                                  ),],),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10.0))),
                                    elevation: 5.0,height: 40,
                                    onPressed: () {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      signUp(Email.text, password.text, role);
                                      },
                                    color: Colors.redAccent.shade700,
                                    child: const Text(
                                      "Sign Up", style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                                    ),),],),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account ",style: TextStyle(fontSize: 18,color: Colors.orange),),
                                  InkWell(
                                    onTap: (){Get.offAllNamed("/login");},
                                    child: Text("Login",style: TextStyle(decoration:TextDecoration.underline,color: Colors.red.shade900,fontSize: 20,fontWeight: FontWeight.bold),),)
                                ],),],),)),),),],),),));}

  void signUp(String email, String password, String rool) async {
    const CircularProgressIndicator();
    if (formState.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }}
 Future postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    if (role == 'User'){
      CollectionReference ref = FirebaseFirestore.instance.collection('users');
      ref.doc(user!.uid).set({
        'email': Email.text,
        'address': address.text,
        'age': age.text,
        'FirstName':Fname.text,
        'LastName':Lname.text,
        'phone':phone.text ,
        'role': role,});
      Get.offAllNamed("/successSign");
    }

    else if ((role == 'Craftsman')){
      Get.offAllNamed("/career");
      shared!.setString('email', Email.text);
      shared!.setString('address', address.text);
      shared!.setString('age', age.text);
      shared!.setString('FirstName', Fname.text);
      shared!.setString('LastName', Lname.text);
      shared!.setString('phone', phone.text);
      shared!.setString('role', role);
      shared!.setString('Career', career);
      shared!.setString('id', FirebaseAuth.instance.currentUser!.uid);
    }}}











