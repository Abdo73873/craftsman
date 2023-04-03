import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:craftsman/standared/images.dart';
import 'package:get/get.dart';

class ForgetPass  extends StatefulWidget{
  const ForgetPass({super.key});

  @override
  ForgetPassState createState() => ForgetPassState();
}
class ForgetPassState extends State<ForgetPass>{

   final formState = GlobalKey<FormState>();
   final email = TextEditingController();

   @override
   void dispose(){
     email.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Forget Password",style: TextStyle(color: Colors.grey.shade600,fontSize: 25)),
         leading: IconButton(icon: Icon (Icons.arrow_back,color: Colors.red.shade700,size: 30,),onPressed: (){
           Get.offAllNamed("/login");
         }) ,
         backgroundColor: Colors.grey.shade50,
         shadowColor: Colors.teal.shade900,
         elevation: 600,),
      body :Container(
        margin: const EdgeInsets.all(15),
        child: Form(
          key: formState,
          child: ListView(
              padding: const EdgeInsets.only(top: 50),
              children: [
                Image.asset(image.image7,height: 100,),
                const SizedBox(height: 20),
                const Text(" Check Email !",style: TextStyle(color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                const SizedBox(height: 13),
                const Text("Please Enter your Email to reset \n your password !",style: TextStyle(color: Colors.blueGrey,fontSize: 17,),textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                  filled: true,
                  labelText: 'Email',
                  enabled: true,
                  prefixIcon: Icon(Icons.email,color: Colors.red.shade500,),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red.shade200, width: 2,)),

                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red.shade500, width: 2,))),

                ),
                const SizedBox(height: 50,),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                  elevation: 10.0,height: 40,
                  onPressed: passwordReset,
                  color: Colors.red.shade500,
                  child: const Text(
                    "Submit", style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ),),);

    }
   Future passwordReset() async{
     try{
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
       showDialog(
           context: context,
           builder: (context){
             return const AlertDialog(
               content: Text('Password reset link sent! Check your email'),
             );
           });
       Get.offAllNamed("/login");
     }on FirebaseAuthException catch(e){
       print(e);
       showDialog(
           context: context,
           builder: (context){
             return AlertDialog(
               content: Text(e.message.toString()),
             );
           });
     }}}