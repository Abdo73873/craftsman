import 'package:craftsman/crafts/Electrical.dart';
import 'package:craftsman/crafts/carpenter.dart';
import 'package:craftsman/crafts/technician.dart';
import 'package:craftsman/profile/profile.dart';
import 'package:craftsman/authentaction/register.dart';
import 'package:craftsman/authentaction/successSign.dart';
import 'package:craftsman/home/craftHome.dart';
import 'package:craftsman/requests/accepted.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentaction/careers.dart';
import '../authentaction/forgetPass.dart';
import '../chats/chats_screen.dart';
import '../crafts/painter.dart';
import '../crafts/plumper.dart';
import '../UserHelp/UserHelp.dart';
import '../home/Userhome.dart';
import '../authentaction/login.dart';
import '../request/admin request.dart';

import '../requests/Requests.dart';
import 'middleware.dart';
import '../home/more.dart';
List<GetPage<dynamic>> ? routes = [
  GetPage(name: "/", page: () =>  const Login() , middlewares: [
    middleware(),
  ] ),
  GetPage(name: "/login", page: () => const Login() ),
  GetPage(name: "/career", page: () => const Career() ),
  GetPage(name: "/homepage", page: () =>const UserHome() ),
  GetPage(name: "/homepage2", page: () =>const CraftHome() ),
  //GetPage(name: "/page1", page: () =>const Page1() ),
  GetPage(name: "/register", page: () => const Register() ),
  GetPage(name: "/forget", page: () => const ForgetPass() ),
  GetPage(name: "/successSign", page: () =>const SuccessSign() ),
  //GetPage(name: "/pageView", page: () =>PageView() ),
  GetPage(name: "/more", page: () =>More() ),
  GetPage(name: "/profile", page: () =>const Profile() ),
  GetPage(name: "/carpenter", page: () =>const Carpenter() ),
  GetPage(name: "/electrical", page: () =>const Electrical() ),
  GetPage(name: "/plumper", page: () =>const Plumper() ),
  GetPage(name: "/technician", page: () =>const Technician() ),
  GetPage(name: "/painter", page: () =>const Painter() ),
  GetPage(name: "/RequestsScreen2", page: () =>RequestsScreen2() ),
  GetPage(name: "/RequestsScreen3", page: () =>const RequestsScreen3() ),
  GetPage(name: "/ChatsScreen", page: () =>ChatsScreen() ),
  GetPage(name: "/AcceptedRequests", page: () =>const AcceptedRequests() ),
  GetPage(name: "/Userhelp", page: () =>UserHelp() ),

];