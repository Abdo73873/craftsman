import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/home/get_myData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../constant/constant.dart';
import '../models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);
  List<NotificationModel> notify = [];

  Future<void> streamNotification() async {
    // await Future.delayed(const Duration(seconds: 2));
    if (myModel == null) {
          await getMyData();
    }
    String to = "craftsman";
    if (myModel!.role == "user") {
      to = "user";
    }
    FirebaseFirestore.instance
        .collection(to)
        .doc(myId)
        .collection('notification')
        .snapshots()
        .listen((event) {
      notify = [];
      for (var element in event.docs) {
        notify.add(NotificationModel.fromJson(element.data()));
      }
      if (notify.isNotEmpty) {
        Fluttertoast.showToast(
          msg: notify.last.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      emit(StreamNotificationState());
    });
  }

  void clearNotification() {
    String to = "craftsman";
    if (myModel!.role == "user") {
      to = "user";
    }
    FirebaseFirestore.instance
        .collection(to)
        .doc(myId)
        .collection('notification')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.delete();
      }
    });
  }
}
