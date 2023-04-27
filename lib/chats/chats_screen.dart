// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:craftsman/chats/chat_item.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/constant/app_images.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/models/person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';

class ChatsScreen extends StatefulWidget {
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Person> friends = [];
  bool isEmpty=false;
  @override
  void initState() {
    List<String> persons = [];
    late String from,to;
    if (myModel!.role == 'user') {
      from='user';
      to = 'craftsman';
    }
    else {
      from='craftsman';
      to = 'user';
    }
    FirebaseFirestore.instance
        .collection(from)
        .doc(myId)
        .collection('persons')
        .snapshots()
        .listen((event) {
      friends = [];
      persons = [];
      for (var element in event.docs) {
        persons.add(element.id);

      }
      _getFriends(persons,to);
    });

    super.initState();
  }

void _getFriends(List<String> persons,to){
  FirebaseFirestore.instance.collection(to)
      .get()
      .then((value) {
    for (var doc in value.docs) {
      if (persons.contains(doc.id)) {
        friends.add(Person.fromJson(doc.data()));
      }
    }
    if(friends.isEmpty){
      isEmpty=true;
    }
    setState(() {});
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat",style: TextStyle(color: Colors.white,fontSize: 30)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: (){
            if(myModel!.role=='user') {
              Get.offAllNamed('/homepage');
            }else{
              Get.offAllNamed('/homepage2');

            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ConditionalBuilder(
        condition: friends.isNotEmpty,
        builder:(context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index)=>streamBuildChatItem(context, friends[index]),
              separatorBuilder: (context, index) => SizedBox(
              height: 20,
            ),
            itemCount: friends.length,
          ),
        ),
        fallback:(context) =>Center(
            child: isEmpty?Text('Empty'): CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget streamBuildChatItem(context, Person person) {
    String from='craftsman';
    if(myModel!.role=='user'){
      from='user';
    }
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatItemScreen(person),));
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(from)
            .doc(myId)
            .collection('persons')
            .doc(person.uId)
            .collection('chat')
            .where('senderId', isEqualTo: person.uId)
            .snapshots(),
        builder: (context, snapshot) {
          String text = '';
          String lastTime = '';
          int last = 0;
          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              if (element.data().isNotEmpty) {
                if (int.parse(element.data()['indexMessage'].toString()) >= last) {

                  lastTime=Jiffy().from(Jiffy(element.data()['dateTime'], 'EEEE, MMMM d, yyyy h:mm a'));

                  text = element
                      .data()['text']
                      .toString()
                      .substring(0, element.data()['text'].toString().length);
                  last = int.parse(element.data()['indexMessage'].toString());
                }
              }
            }
          }
          return buildChatItem(context, person, text, lastTime);
        },
      ),
    );
  }

  Widget buildChatItem(context, Person person, String text, String lastTime) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.cyan.shade800,
            radius: 35.0,
            child: ClipOval(
              child: person.image!=null
              ?CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageUrl: person.image!,
                errorWidget: (context, url, error) => Image.asset(
                  AppImages.profile,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
                  :Image.asset(AppImages.profile,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      if (lastTime.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Container(
                            height: 8.0,
                            width: 8.0,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      Text(

                        lastTime,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
