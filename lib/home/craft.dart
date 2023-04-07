
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../standared/exitApp.dart';


class HomePage2  extends StatefulWidget{
  const HomePage2 ({Key? key}) : super(key: key);
  @override
  HomeState  createState () => HomeState();

}

class HomeState extends State<HomePage2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
           Get.offAllNamed("/RequestsScreen3");
          },
          child: Icon(
            Icons.notifications, size: 35, color: Colors.red.shade700,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
              Row(children: [
                MaterialButton(onPressed: () {
                  Navigator.of(context).pushNamed("/homepage");
                },
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, size: 35, color: Colors.red.shade600),
                        const Text("Home")
                      ]),
                )
              ],),
              Row(children: [
                MaterialButton(onPressed: () {
                  Navigator.of(context).pushNamed("/profile");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_circle_rounded,
                          size: 35, color: Colors.red.shade600),
                      const Text("Profile")
                    ],
                  ),
                )
              ],),

              const Spacer(),

              Row(children: [
                MaterialButton(onPressed: () {
                  Get.offAllNamed("/UserChat");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat, size: 35, color: Colors.red.shade600),
                      const Text("Chat")
                    ],
                  ),
                )
              ],),
              Row(children: [
                MaterialButton(onPressed: () {
                  Navigator.of(context).pushNamed("/more");
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.more_horiz, color: Colors.red.shade600,
                        size: 35,),
                      const Text("More")
                    ],
                  ),
                )
              ],),
            ],
          ),


        ),


        appBar: AppBar(
          title: const Text(
              "Home", style: TextStyle(color: Colors.white, fontSize: 30)),
          backgroundColor: Colors.red.shade600,
          leading: Icon(
              Icons.home_rounded, size: 40, color: Colors.blueGrey.shade100),
        ),
        body: WillPopScope(
          onWillPop: ExitApp,
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Text(""),
          ),


        ));
  }
}