
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../standared/exitApp.dart';
import 'get_myData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class UserHome  extends StatefulWidget{
  const UserHome ({Key? key}) : super(key: key);
  @override
  HomeState  createState () => HomeState();

}

class HomeState extends State<UserHome>{
  var fmess = FirebaseMessaging.instance;
@override
  void initState() {
  fmess.getToken().then((value) {
    print("object");
  print(value);});

  FirebaseMessaging.onMessage.listen((event) {
    print("object");
    print("${event.notification?.body}");
  });
  getMyData();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){},
          child: Icon(Icons.notifications,size: 35,color: Colors.cyan.shade700,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
              Row(children: [
                MaterialButton(onPressed: (){
                  Navigator.pushNamed(context, "/homepage");
                },
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home,size: 35,color: Colors.cyan.shade700),
                        const Text("Home")
                      ]),
                )
              ],),
              Row(children: [
                MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed("/profile");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_circle_rounded,
                          size: 35,color: Colors.cyan.shade700),
                      const Text("Profile")
                    ],
                  ),
                )
              ],),

              const Spacer(),

              Row(children: [
                MaterialButton(onPressed: (){
                Get.offNamed("/ChatsScreen");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.chat,size: 35,color: Colors.cyan.shade700),
                      const Text("Chat")
                    ],
                  ),
                )
              ],),
              Row(children: [
                MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed("/more");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.more_horiz,color: Colors.cyan.shade700,size: 35,),
                      const Text("More")
                    ],
                  ),
                )
              ],),
            ],
          ),



        ),


        appBar: AppBar(
          title: const Text("Home",style: TextStyle(color: Colors.white,fontSize: 30)),
          backgroundColor: Colors.cyan.shade800,
          leading: Icon(Icons.home_rounded,size: 40,color: Colors.blueGrey.shade100),
        ),
        body: WillPopScope(
          onWillPop:ExitApp,
          child :Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField (
                  decoration: InputDecoration(
                      labelText: ("Type your proplem here"),
                      labelStyle: const TextStyle(fontSize: 20,color: Colors.grey,),

                      prefixIcon: const Icon(Icons.type_specimen,color: Colors.grey,),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.cyan.shade600, width: 2,)),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.cyan, width: 2,))
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 5),backgroundColor: Colors.cyan.shade800,),
                  onPressed: (){
                    Get.offAllNamed("/plumper");},
                  child: const Text("Send")),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 100,
                        child: Image.asset(image.image11,)),
                    const SizedBox(width: 5,),
                    CircleAvatar(
                        radius: 100,
                        child: Image.asset(image.image12,)),

                  ],
                ),
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    CircleAvatar(
                        radius: 100,
                        child: Image.asset(image.image13,)),
                    const SizedBox(width: 5,),
                    CircleAvatar(
                        radius: 100,
                        child: Image.asset(image.image14,)),


                  ],
                ),
              ),

            ],
          ),
        ));
  }
}