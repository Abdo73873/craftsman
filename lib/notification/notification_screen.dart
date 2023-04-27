import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/constant/app_images.dart';
import 'package:craftsman/notification/notification_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../constant/constant.dart';
import '../models/notification_model.dart';

void sendToFireStore({
  String? name,
  String? uId,
  String? image,
  required String title,
  required String message,
  required String dateTime,
}) {
  String to = "craftsman";
  if (myModel!.role == "user") {
    to = "user";
  }
  NotificationModel model = NotificationModel(
      name: name,
      uId: uId,
      image: image,
      title: title,
      message: message,
      dateTime: dateTime);

  FirebaseFirestore.instance
      .collection(to)
      .doc(myId)
      .collection('notification')
      .add(model.toMaP());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data['id'] != myId) {
    sendToFireStore(
      name: message.data['name'],
      uId: message.data['id'],
      image: message.data['image'],
      title: message.notification!.title!,
      message: message.notification!.body!,
      dateTime: DateFormat.yMd().add_jms().format(message.sentTime!).toString(),
    );
  }
}

Future<void> firebaseMessaging(RemoteMessage message) async {
  if (message.data['id'] != myId) {
    sendToFireStore(
      name: message.data['name'],
      uId: message.data['id'],
      image: message.data['image'],
      title: message.notification!.title!,
      message: message.notification!.body!,
      dateTime: DateFormat.yMd().add_jms().format(message.sentTime!).toString(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notificationCubit,
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NotificationCubit.get(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.primary,
              title: const Text('Notification'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: OutlinedButton(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      fixedSize: MaterialStatePropertyAll(Size.zero),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      side: MaterialStatePropertyAll(
                          BorderSide(width: 2, color: Colors.purple)),
                    ),
                    onPressed: () {
                      cubit.clearNotification();
                    },
                    child: const Text(
                      'clear',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: 8.0,
                          end: 20.0,
                        ),
                        child: Icon(
                          Icons.notifications,
                        ),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.purple,
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
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            body: cubit.notify.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return buildNotifyItem(context, cubit.notify[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: cubit.notify.length,
                    ),
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }

  Widget buildNotifyItem(context, NotificationModel model) => Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            child: ClipOval(
              child: model.image != null
                  ? CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: model.image!,
                      errorWidget: (context, url, error) => Image.asset(
                        AppImages.profile,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      AppImages.profile,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  '${model.message}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  model.dateTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      );
}
