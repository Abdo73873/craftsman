part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class StreamNotificationState extends NotificationState {}
class ChangeListenState extends NotificationState {}
