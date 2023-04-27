class Person {
  late String name;
  late String email;
  late String uId;
  late String phone;
  late String address;
  late int age;
  late String role;
   String? image;
   String? deviceToken;

  Person({
    required this.name,
    required this.email,
    required this.uId,
    required this.phone,
    required this.address,
    required this.age,
    required this.role,
    this.image,
    this.deviceToken,
  });

  Person.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    uId = json["uId"];
    phone = json["phone"];
    address = json["address"];
    age = json["age"];
    role = json["role"];
    image = json["image"];
    deviceToken = json["deviceToken"];
  }

  Map<String, dynamic> toMaP() {
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "phone": phone,
      "address": address,
      "age": age,
      "role": role,
      "image": image,
      "deviceToken": deviceToken,
    };
  }
}

