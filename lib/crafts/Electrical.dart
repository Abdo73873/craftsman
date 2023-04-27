
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Electrical extends StatefulWidget {

  const Electrical({Key? key}) : super(key: key);

  @override
  ElectricalState createState() => ElectricalState();
}
class ElectricalState extends State<Electrical>{

  var electrician = FirebaseFirestore.instance.collection("craftsman").
  where("role",isEqualTo: "Electrician");
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
        title:  Text("Choose an electrician",style: TextStyle(fontSize: 25,color: Colors.grey.shade500),),
        backgroundColor:Colors.cyan.shade700,
        centerTitle: true,
        leading: IconButton(icon: Icon (Icons.arrow_back,color: Colors.grey.shade500,),onPressed: (){
          Get.offAllNamed("/homepage");
        }) ,
      ),

      body : Column(
        children: [
          Image.asset(image.image18,),
          Expanded(
            child: FutureBuilder(
                future: electrician.get(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return ElectricalList(
                              electrical : snapshot.data.docs[i],
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
class ElectricalList extends StatelessWidget{
  final electrical;
  final id;
  ElectricalList({super.key,
    this.electrical, this.id
  });

  GlobalKey<FormState> formstate =  GlobalKey <FormState>();

  final ValueNotifier<bool> isRequested= ValueNotifier<bool> (false);

  @override
  Widget build (BuildContext context){
    return
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return view(crafts: electrical,);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [

                      Expanded(
                        flex: 3,
                        child: ListTile(
                          title: Text("\n${electrical['name']}",),
                          subtitle: Text("\n${electrical['role']}"),
                          textColor: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          subtitle: Text("\n${electrical['phone']}",),
                          textColor: Colors.black,

                        ),
                      ),

                      Expanded(
                          flex: 4,
                          child: ListTile(

                            trailing:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan.shade500,),
                              child:  Text('Send Request '),
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
              );


  }

}
