import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

import '../../constant/constant.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context)=>BlocProvider.of(context);
  void typing(){
    emit(ChatTypingState());
  }
@override
  Future<void> close() {
streamMessage.cancel();
return super.close();
  }


  void typeComment(){
    emit(CommentTypingState());
  }
  void sendMessage({
    required String receiverId,
    required String text ,
    String? image,
  }){
    MessageModel message=MessageModel(
      senderId: myId!,
      text: text,
      dateTime: Jiffy().yMMMMEEEEdjm,
      receiverId: receiverId,
      indexMessage:messages.length,
      image: image,

    );
    late String from,to;
    if (myModel!.role == 'user') {
      from='user';
      to = 'craftsman';
    }
    else {
      from='craftsman';
      to = 'user';
    }
    //set my chars
    FirebaseFirestore.instance
        .collection(from)
        .doc(myId)
        .collection('persons')
        .doc(receiverId)
        .collection('chat')
        .add(message.toMap()).then((value) {
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });

    //set receiver chars
    FirebaseFirestore.instance
        .collection(to)
        .doc(receiverId)
        .collection('persons')
        .doc(myId)
        .collection('chat')
        .add(message.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });



  }


  String friendId='';
  List<MessageModel> messages=[];
  late StreamSubscription<QuerySnapshot> streamMessage;
 void getMessage(String friedId){
    late String from;
    friendId=friedId;
    if(myModel!.role=='user'){
       from='user';
    }else{
      from='craftsman';
    }
      streamMessage= FirebaseFirestore.instance
        .collection(from)
        .doc(myId)
        .collection('persons')
        .doc(friedId)
        .collection('chat')
        .orderBy('indexMessage')
        .snapshots()
        .listen((event) {
      messages=[];
      for (var messageId in event.docs) {
        messages.add(MessageModel.fromJson(messageId.data()));
      }
      emit(ReceiveMessageSuccessState());
    });

  }

  final picker = ImagePicker();
  File? chatImage;

  Future getChatImage(isGallery) async {
    ImageSource source;
    if (isGallery) {
      source = ImageSource.gallery;
    } else {
      source = ImageSource.camera;
    }
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(ChatGetImageSuccessState());
    } else {
      print('no image selected');
      emit(ChatGetImageErrorState());
    }
  }

  bool isUploadChatImageCompleted=true;
  void uploadChatImage({
    required String receiverId,
    String? text,
  }) {
    isUploadChatImageCompleted=false;
    emit(ChatUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri
        .file(chatImage!.path)
        .pathSegments
        .last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          text: text!,
          image: value,
        );
        chatImage=null;
        isUploadChatImageCompleted=true;
        emit(ChatUploadImageSuccessState());
      }).catchError((error) {
        emit(ChatUploadImageErrorState());
      });
    }).catchError((error) {
      emit(ChatUploadImageErrorState());
    });
  }

  void removeChatImage(){
    chatImage=null;
    emit(ChatRemoveImageState());
  }
}
