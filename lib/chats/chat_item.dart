// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftsman/constant/app_images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/app_color.dart';
import '../constant/constant.dart';
import '../models/person.dart';
import 'cubit/chat_cubit.dart';
import '../models/message_model.dart';

class ChatItemScreen extends StatelessWidget {
  late Person person;

  ChatItemScreen(this.person);

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getMessage(person.uId),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 25.0,
                    child: ClipOval(
                      child:person.image!=null
                          ? CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl:'${Uri.parse(person.image!)}',
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
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    person.name,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  if (cubit.messages[index].senderId == myId) {
                                    return buildMyMessage(context, cubit.messages[index]);
                                  }
                                  return buildMessage(context, cubit.messages[index]);
                                },
                                separatorBuilder: (context, index) {
                                  if(index==0){
                                    return SizedBox(
                                      height: 10.0,
                                    );
                                  }
                                  else if(cubit.messages[index].dateTime.split(',')[0]!=cubit.messages[index-1].dateTime.split(',')[0]){
                                    return  showDay(cubit.messages[index].dateTime.split(',')[0]);
                                  }else{
                                   return SizedBox(
                                      height: 10.0,
                                    );
                                  }
                                },
                                itemCount: cubit.messages.length,
                                physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                shrinkWrap: true,
                                dragStartBehavior: DragStartBehavior.down,
                              ),
                              if (scrollController.hasClients)
                                if (scrollController.offset <= scrollController.position.maxScrollExtent - 20.0)
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: IconButton(
                                      onPressed: () {
                                        if (scrollController.hasClients) {
                                          scrollController
                                              .animateTo(
                                                  scrollController
                                                      .position
                                                      .maxScrollExtent,
                                                  duration: Duration(
                                                      seconds: 2),
                                                  curve: Curves.linear)
                                              .then((value) {
                                            cubit.typing();
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        size: 50.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is! ChatUploadImageLoadingState)
                  if (cubit.chatImage != null)
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image.file(
                            cubit.chatImage!,
                            height: 200,
                            width: double.infinity,
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.removeChatImage();
                            },
                            icon: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                if (!cubit.isUploadChatImageCompleted)
                  CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 5.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (messageController.text.isEmpty)
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(.9),
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(10.0),
                              bottomStart: Radius.circular(10.0),
                            ),
                            border: Border.all(),
                          ),
                          child: Row(
                            children: [
                              MaterialButton(
                                padding: EdgeInsetsDirectional.all(.8),
                                minWidth: 1,
                                onPressed: () {
                                  cubit.getChatImage(false);
                                },
                                child: Icon(
                                  Icons.camera,
                                  size: 25.0,
                                  color:
                                      Theme.of(context).iconTheme.color,
                                ),
                              ),
                              MaterialButton(
                                padding: EdgeInsetsDirectional.all(.8),
                                minWidth: 1,
                                onPressed: () {
                                  cubit.getChatImage(true);
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 25.0,
                                  color:
                                      Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: SizedBox(
                          height: messageController.text.isEmpty
                              ? 50.0
                              : null,
                          child: TextFormField(
                            onChanged: (value) {
                              ChatCubit.get(context).typing();
                            },
                            controller: messageController,
                            minLines: 1,
                            maxLines: 4,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1),
                              border: OutlineInputBorder(),
                              hintText: ' type your message here...',
                              hintStyle:
                                  Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 45.0,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10.0),
                            bottomEnd: Radius.circular(10.0),
                          ),
                          border: Border.all(),
                        ),
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsetsDirectional.all(.8),
                          onPressed: () {
                            if (cubit.chatImage != null) {
                              cubit.uploadChatImage(
                                receiverId: person.uId,
                                text: messageController.text,
                              );
                              cubit.isUploadChatImageCompleted == false;
                            } else {
                              cubit.sendMessage(
                                  receiverId: person.uId,
                                  text: messageController.text,
                              );
                            }
                            messageController.clear();
                          },
                          child: Icon(
                            Icons.send,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMessage(context, MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(15.0),
              topStart: Radius.circular(15.0),
              topEnd: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.image != null)
                    if (message.image!.isNotEmpty)
                      CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(),
                        imageUrl: message.image!,
                        width: 250,
                        fit: BoxFit.fitHeight,
                        errorWidget: (context, url, error) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                  Text(message.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              Text(
                '${message.dateTime.split(',')[2].split(' ')[2]} '
                    '${message.dateTime.split(',')[2].split(' ')[3]}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
  Widget showDay(String day)=>Align(
    alignment: AlignmentDirectional.center,
      child: Text(day));
  Widget buildMyMessage(context, MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(15.0),
              topStart: Radius.circular(15.0),
              topEnd: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.image != null)
                    if (message.image!.isNotEmpty)
                      CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(),
                        imageUrl: message.image!,
                        width: 250,
                        fit: BoxFit.fitHeight,
                        errorWidget: (context, url, error) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                  Text(message.text,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          )),
                ],
              ),
              SizedBox(height: 2,),
              Text(
                '${message.dateTime.split(',')[2].split(' ')[2]} '
                '${message.dateTime.split(',')[2].split(' ')[3]}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      );
}
