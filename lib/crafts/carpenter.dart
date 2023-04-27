
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Carpenter extends StatefulWidget {

  const Carpenter({Key? key}) : super(key: key);

  @override
  CarpenterState createState() => CarpenterState();
}
class CarpenterState extends State<Carpenter>{

  var carpenters = FirebaseFirestore.instance.collection("craftsman").
  where("role",isEqualTo: "Carpenter");
  String? name ='';



  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build (BuildContext context)

  {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.cyan.shade800,
        centerTitle: true,
        leading: IconButton(icon:const Icon (Icons.arrow_back),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : Column(
        children: [
          Image.asset(image.image17,),
          Expanded(
            child: FutureBuilder(
                future: carpenters.get(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return CarpentersList(
                              carpenter : snapshot.data.docs[i],
                              id: snapshot.data.docs[i].id);
                        });
                  }
                  return const Center(child: CircularProgressIndicator(),);
                }),
          ),
        ],
      ),
    );

  }
}
class CarpentersList extends StatelessWidget{
  final carpenter;
  final id;
  CarpentersList({super.key,
    this.carpenter, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  final ValueNotifier<bool> isRequested= ValueNotifier<bool> (false);

  @override
  Widget build (BuildContext context){
    return Column(
      children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return view(crafts: carpenter,);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [

                      Expanded(
                        flex: 3,
                        child: ListTile(
                          title: Text("\n${carpenter['name']}",),
                          subtitle: Text("\n${carpenter['role']}"),
                          textColor: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          subtitle: Text("\n${carpenter['phone']}",),
                          textColor: Colors.black,

                        ),
                      ),

                      Expanded(
                          flex: 4,
                          child: ListTile(

                            trailing:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan.shade800,),
                              child:  const Text('Send Request '),
                              onPressed: () {

                                isRequested.value=!isRequested.value;
                                FirebaseFirestore.instance.collection('craftsman')
                                    .doc(id).collection("request")
                                    .add({
                                  'Email': myModel?.name,
                                  'userId': myModel?.uId,
                                  'status': 'pending',

                                });
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Request Sent !',
                                    desc: 'Wait until you are notified of accepting or rejecting your request',
                                    btnOkOnPress: () {
                                      Navigator.of(context).pushReplacementNamed("/homepage");
                                    },
                                    btnOkColor: Colors.cyan.shade800
                                ).show();
                                // Send request to Firebase
                              },
                            ),

                          )
                      ),

                    ],
                  ),

                ),
              ),


      ],
    );
  }

}
