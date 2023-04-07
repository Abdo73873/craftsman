part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatTypingState extends ChatState {}
class CommentTypingState extends ChatState {}
class SendMessageSuccessState extends ChatState {}
class SendMessageErrorState extends ChatState {}
class ReceiveMessageSuccessState extends ChatState {}
class ChatGetImageSuccessState extends ChatState {}
class ChatGetImageErrorState extends ChatState {}
class ChatUploadImageLoadingState extends ChatState {}
class ChatUploadImageSuccessState extends ChatState {}
class ChatUploadImageErrorState extends ChatState {}
class ChatRemoveImageState extends ChatState {}
