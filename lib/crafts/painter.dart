
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Painter extends StatefulWidget {

  const Painter({Key? key}) : super(key: key);

  @override
  PainterState createState() => PainterState();
}
class PainterState extends State<Painter>{

  var painters = FirebaseFirestore.instance.collection("craftsman").
  where("role",isEqualTo: "Electrical");
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
        backgroundColor:const Color.fromRGBO(39, 144, 176, 1),
        centerTitle: true,
        leading: IconButton(icon:const Icon (Icons.arrow_back),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : Column(
        children: [
          Image.asset(image.image16,),
          Expanded(
            child: FutureBuilder(
                future: painters.get(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return PaintersList(
                              painter : snapshot.data.docs[i],
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
class PaintersList extends StatelessWidget{
  final painter;
  final id;
  PaintersList({super.key,
    this.painter, this.id
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
                    return view(crafts: painter,);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [

                      Expanded(
                        flex: 3,
                        child: ListTile(
                          title: Text("\n${painter['name']}",),
                          subtitle: Text("\n${painter['role']}"),
                          textColor: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          subtitle: Text("\n${painter['phone']}",),
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

