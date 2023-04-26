
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:craftsman/standared/exitApp.dart';
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Plumper extends StatefulWidget {

  const Plumper({Key? key}) : super(key: key);

  @override
  PlumperState createState() => PlumperState();
}
class PlumperState extends State<Plumper>{

  var plumper = FirebaseFirestore.instance.collection("craftsman").
  where("role",isEqualTo: "Plumper");
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
        title:  const Text("Choose a plumper",style: TextStyle(fontSize: 25,color: Colors.white),),
        backgroundColor:const Color.fromRGBO(40,132,147,1),
        centerTitle: true,
        leading: IconButton(icon: const Icon (Icons.arrow_back,color: Colors.white,),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : Column(
        children: [
          Image.asset(image.image19,),
          Expanded(
            child: FutureBuilder(
                future: plumper.get(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return PlumperList(
                              plumpers : snapshot.data.docs[i],
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
class PlumperList extends StatelessWidget{
  final plumpers;
  final id;
  PlumperList({super.key,
    this.plumpers, this.id
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
                    return view(crafts: plumpers,);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [

                      Expanded(
                        flex: 3,
                        child: ListTile(
                          title: Text("\n${plumpers['name']}",),
                          subtitle: Text("\n${plumpers['role']}"),
                          textColor: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          subtitle: Text("\n${plumpers['phone']}",),
                          textColor: Colors.black,

                        ),
                      ),

                      Expanded(
                          flex: 4,
                          child: ListTile(

                            trailing:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(40,132,147,1),),
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
