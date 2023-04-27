
class NotificationModel {
    String? name;
    String? uId;
    String? image;
  late String title;
  late String message;
  late String dateTime;

  NotificationModel({
      this.name,
     this.uId,
      this.image,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    uId = json["uId"];
    image = json["image"];
    title = json["title"];
    message = json["message"];
    dateTime = json["dateTime"];
  }

  Map<String, dynamic> toMaP() {
    return {
      "name": name,
      "uId": uId,
      "image": image,
      "title": title,
      "message": message,
      "dateTime": dateTime,
    };
  }
}
