

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/app_color.dart';
import 'package:craftsman/constant/app_images.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String errormessage = '';

  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final userNameController = TextEditingController();
  final phonefocus = FocusNode();
  final userNamefocus = FocusNode();
  final addressfocus = FocusNode();

  Future<void> showPhoneDialogAlert (BuildContext context , String phone){
   phoneController.text = phone;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Update phone',style: TextStyle(color: Colors.cyan.shade900),),
          content:  SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                    filled: true,
                    labelText: 'Enter your new phone',
                    enabled: true,
                    prefixIcon: Icon(Icons.phone,color: Colors.cyan.shade800,),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.cyan.shade700, width: 2,)),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.cyan.shade500, width: 2,))),
                controller: phoneController,
                focusNode: phonefocus ,
                onFieldSubmitted: (value){
                },
                keyboardType: TextInputType.phone,
                obscureText: false,
                onChanged: (value){},)],),),
          actions: [
          TextButton(onPressed: () async{
            setState(() {
              myModel!.phone = phoneController.text;
            });
            if(myModel!.role=='user'){
              FirebaseFirestore.instance.collection('user').doc(myId).update(
                  {
                    'phone' : myModel!.phone
                  });
            }
            else{
              FirebaseFirestore.instance.collection('craftsman').doc(FirebaseAuth.instance.currentUser!.uid).update(
                  {
                    'phone' : myModel!.phone
                  });
            }
          Navigator.pop(context);
        }, child: Text('Ok',style: TextStyle(color: Colors.cyan.shade900),)),
          TextButton(onPressed: (){

        Navigator.pop(context);
      }, child: Text('Cancel',style: TextStyle(color: Colors.cyan.shade900),))]

      );
    });
  }
  Future<void> showuserNameDialogAlert (BuildContext context , String name){
    userNameController.text = name;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text('Update username',style: TextStyle(color: Colors.cyan.shade900),),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                      filled: true,
                      labelText: 'Enter your new UserName',
                      enabled: true,
                      prefixIcon: Icon(Icons.person,color: Colors.cyan.shade800,),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.cyan.shade700, width: 2,)),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.cyan.shade500, width: 2,))),

                  controller: userNameController,
                  focusNode: userNamefocus ,
                  onFieldSubmitted: (value){},
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  onChanged: (value){},)],),),
          actions: [
            TextButton(onPressed: () async{
              setState(() {
                myModel!.name = userNameController.text;
              });
              if(myModel!.role=='user'){
                FirebaseFirestore.instance.collection('user').doc(myId).update(
                    {
                      'name' : myModel!.name
                    });
              }
              else{
                FirebaseFirestore.instance.collection('craftsman').doc(FirebaseAuth.instance.currentUser!.uid).update(
                    {
                      'name' : myModel!.name
                    });
              }
              Navigator.pop(context);
            }, child: Text('Ok',style: TextStyle(color: Colors.cyan.shade900),)),
            TextButton(onPressed: (){

              Navigator.pop(context);
            }, child: Text('Cancel',style: TextStyle(color: Colors.cyan.shade900),))]

      );
    });
  }
  Future<void> showaddressDialogAlert (BuildContext context , String address){
    addressController.text = address;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text('Update Address',style: TextStyle(color: Colors.cyan.shade900),),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelStyle:const TextStyle(fontSize: 17,color: Colors.grey,fontWeight: FontWeight.w500) ,
                      filled: true,
                      labelText: 'Enter your new Address',
                      enabled: true,
                      prefixIcon: Icon(Icons.home,color: Colors.cyan.shade800,),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.cyan.shade700, width: 2,)),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.cyan.shade500, width: 2,))),

                  controller:addressController,
                  focusNode: addressfocus ,
                  onFieldSubmitted: (value){},
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value){},)],),),
          actions: [
            TextButton(onPressed: () async{
              setState(() {
                myModel!.address = addressController.text;
              });
              if(myModel!.role=='user'){
                FirebaseFirestore.instance.collection('user').doc(myId).update(
                    {
                      'address' : myModel!.address
                    });
              }
              else{
                FirebaseFirestore.instance.collection('craftsman').doc(FirebaseAuth.instance.currentUser!.uid).update(
                    {
                      'address' : myModel!.address
                    });
              }
              Navigator.pop(context);
            }, child: Text('Ok',style: TextStyle(color: Colors.cyan.shade900),)),
            TextButton(onPressed: (){

              Navigator.pop(context);
            }, child: Text('Cancel',style: TextStyle(color: Colors.cyan.shade900),))]

      );
    });
  }

  Future<void> deleteAccount()async{
    try{
      User user = auth.currentUser!;

      if(myModel!.role=='user') {
        await user.delete();
      await firestore.collection('user').doc(user.uid).delete();
        await firestore.collection('user').doc(user.uid).collection('request').doc(user.uid).delete();
      }
      else{
        await user.delete();
        await firestore.collection('craftsman').doc(user.uid).delete();
        await firestore.collection('craftsman').doc(user.uid).collection('request').doc(user.uid).delete();
      }
    }
    on FirebaseAuthException catch(e){
      setState(() {
        errormessage = e.message!;
      });
    }
    catch(e){
      setState(() {
        errormessage = 'An error occurred while deleting the account.';
      });
    }
  }


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

                          const SizedBox(height: 35,),
                          ListTile(
                            onTap: () {
                              showuserNameDialogAlert(context ,myModel!.name);
                            },
                            leading: Icon(Icons.person, color: AppColors.primary,
                                size: 20),
                            title: Text("User Name : ${myModel!.name}",
                                style: const TextStyle(fontSize: 19)),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                          ),

                          const SizedBox(height: 35),
                          ListTile(
                            onTap: () {

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
                              showPhoneDialogAlert(context, myModel!.phone);
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
                              showaddressDialogAlert(context ,myModel!.address);
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

                          ),
                          const SizedBox(height: 35),

                          ListTile(
                            onTap: () {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                    content:  SingleChildScrollView(
                                    child: Column(
                                    children: const [
                                      Text("Do you Want to delete your account?" ),
                                    ])),
                                  actions: [
                                    TextButton(onPressed: () async{
                                      deleteAccount();
                                      Get.offAllNamed("/login");
                                    }, child: Text('Ok',style: TextStyle(color: Colors.cyan.shade900),)),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('Cancel',style: TextStyle(color: Colors.cyan.shade900),))
                                  ],
                                );
                              });
                            },
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined),
                            leading: Icon(Icons.delete, color : AppColors.primary, size: 20),
                            title: const Text("Delete Account ",
                                style: TextStyle(fontSize: 19)),

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

