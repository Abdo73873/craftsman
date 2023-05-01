import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constant/constant.dart';
import '../notification/notification_cubit.dart';
import '../notification/notification_screen.dart';
import '../standared/exitApp.dart';
import 'get_myData.dart';

class CraftHome extends StatefulWidget {
  const CraftHome({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<CraftHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BlocProvider.value(
          value: notificationCubit..streamNotification(),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              var cubit = NotificationCubit.get(context);
              return Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ));
                    },
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                  if (cubit.notify.isNotEmpty)
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        cubit.notify.length <= 9
                            ? '${cubit.notify.length}'
                            : '+9',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/homepage2");
                    },
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.home, size: 35, color: Colors.red.shade600),
                      const Text("Home")
                    ]),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
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
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.offAllNamed("/ChatsScreen");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat, size: 35, color: Colors.red.shade600),
                        const Text("Chat")
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/more");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.more_horiz,
                          color: Colors.red.shade600,
                          size: 35,
                        ),
                        const Text("More")
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Home",
              style: TextStyle(color: Colors.white, fontSize: 30)),
          backgroundColor: Colors.red.shade600,
          leading: Icon(Icons.home_rounded,
              size: 40, color: Colors.blueGrey.shade100),
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
