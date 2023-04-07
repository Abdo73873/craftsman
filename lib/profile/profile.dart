


import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/constant/app_images.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/models/person.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile  extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? profileImage;
  final picker = ImagePicker();

  Future getImage(isGallery) async {
    ImageSource source;
    if (isGallery) {
      source = ImageSource.gallery;
    } else {
      source = ImageSource.camera;
    }
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        isUploadCompleted=false;
      setState(() {});
    uploadImage(profileImage);

    } else {
      print('no image selected');
      setState(() {});
    }
  }


  bool isUploadCompleted=true;
  void uploadImage(File? image) {
    isUploadCompleted=false;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri
        .file(image!.path)
        .pathSegments
        .last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
          myModel!.image=value;
          updateUser();
          setState(() {});
      }).catchError((error) {
        setState(() {});
      });
    }).catchError((error) {
      setState(() {});
    });
  }


  void updateUser() {
    String from='craftsman';
    if(myModel!.role=='user'){
      from='user';
    }
    FirebaseFirestore.instance
        .collection(from)
        .doc(myId)
        .update(myModel!.toMaP())
        .then((value) {
          isUploadCompleted=true;
      setState(() {});
    })
        .catchError((error) {
          FirebaseFirestore.instance
          .collection(from)
          .doc(myId)
          .get()
          .then((value){
            myModel=Person.fromJson(value.data()!);
            setState(() {});
          });
          isUploadCompleted=true;
          setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.arrow_back_ios_new),),
          title: const Text("Profile"),
          backgroundColor: AppColors.primary,
        ),
        body: Stack(
          children: [
            SafeArea(child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                Expanded(
                    child: ListView(
                        children: [
                          const SizedBox(height: 10,),
                            if(!isUploadCompleted)
                            LinearProgressIndicator(
                              color: AppColors.primary,
                              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                            ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundColor:AppColors.primary,
                                  child: CircleAvatar(
                                    backgroundColor:Colors.white,
                                    radius: 98.0,
                                    child: ClipOval(
                                      child: profileImage == null
                                          ? myModel!.image!=null
                                          ?CachedNetworkImage(
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: myModel!.image!,
                                        errorWidget: (context, url, error) =>
                                            Image.asset( AppImages.profile,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                      )
                                            :  Image.asset(AppImages.profile ,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.file(
                                        profileImage!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                addPic(context),
                              ],
                            ),
                          ),
                          /* GestureDetector(
                          onTap: (){},
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: imageFile==null?
                              AssetImage(image):
                              Image.file(imageFile!).image
                            ),
                          ),
                        ),*/

                          const SizedBox(height: 35,),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(Icons.person, color: AppColors.primary,
                                size: 20),
                            title: Text("User Name : ${myModel!.name}",
                                style: const TextStyle(fontSize: 19)),

                          ),

                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(Icons.email, color: AppColors.primary, size: 20),
                            title: Text("Email : " + "\n${myModel!.email}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),
                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(Icons.phone, color: AppColors.primary, size: 20),
                            title: Text("Phone : ${myModel!.phone}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),
                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(
                                Icons.text_snippet_sharp, color: AppColors.primary, size: 20),
                            title: Text("Age: " + "${myModel!.age}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),
                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(Icons.home_rounded, color: AppColors.primary, size: 20),
                            title: Text("Address: ${myModel!.address}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),
                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {
                              Get.off("");
                            },
                            leading: Icon(Icons.person, color: AppColors.primary, size: 20),
                            title: Text("Career : ${myModel!.role}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),
                        ])
                )
              ],),
            )
            )
          ],
        )
    );
  }

  Widget addPic(context)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
        radius: 20.0,
        backgroundColor: AppColors.primary,
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.9),
                  shadowColor:  AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ),
                  actionsOverflowAlignment:
                  OverflowBarAlignment.center,
                  actionsPadding:
                  const EdgeInsets.all(20.0),
                  elevation: 20.0,
                  title: Text(
                    'Choose Source :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    OutlinedButton(
                      child: Row(
                        children: [
                          Icon(Icons.photo,
                            color: Theme.of(context).iconTheme.color!,),
                          const SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            "From Gallery",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                      onPressed: () {
                         getImage(true);
                          Navigator.pop(context);
                      },
                    ),
                    OutlinedButton(
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt,
                            color: Theme.of(context).iconTheme.color!,),
                          const SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            "From Camera",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                      onPressed: () {
                          getImage(false);
                          Navigator.pop(context);

                      },
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.camera_alt_rounded,
              color: Colors.white,
              size: 25.0,
            ))),
  );

}

