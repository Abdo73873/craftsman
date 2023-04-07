import 'package:craftsman/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../standared/exitApp.dart';
import 'get_myData.dart';

class HomePage  extends StatefulWidget{
  const HomePage ({Key? key}) : super(key: key);
  @override
  HomeState  createState () => HomeState();

}

class HomeState extends State<HomePage>{
@override
  void initState() {
  getMyData();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){},
          child: Icon(Icons.notifications,size: 35,color: Colors.red.shade700,),
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
                  Navigator.of(context).pushNamed("/homepage");
                },
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home,size: 35,color: Colors.red.shade600),
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
                          size: 35,color: Colors.red.shade600),
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
                    children: [Icon(Icons.chat,size: 35,color: Colors.red.shade600),
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
                    children: [Icon(Icons.more_horiz,color: Colors.red.shade600,size: 35,),
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
          backgroundColor: Colors.red.shade600,
          leading: Icon(Icons.home_rounded,size: 40,color: Colors.blueGrey.shade100),
        ),
        body: WillPopScope(
          onWillPop:ExitApp,
          child :Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField (
                  decoration: InputDecoration(
                      labelText: ("Type your proplem here"),
                      labelStyle: const TextStyle(fontSize: 20,color: Colors.grey,),

                      prefixIcon: const Icon(Icons.type_specimen,color: Colors.grey,),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red.shade400, width: 2,)),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.red, width: 2,))
                  ),
                ),

              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Get.offAllNamed("/painter");},
                  child: Text("Ok"))
            ],
          ),
        ));
  }
}