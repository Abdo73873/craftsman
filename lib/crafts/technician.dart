import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftsman/constant/constant.dart';
import 'package:craftsman/profile/viewProfile.dart';
import 'package:craftsman/standared/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Technician extends StatefulWidget {

  const Technician({Key? key}) : super(key: key);

  @override
  TechnicianState createState() => TechnicianState();
}
class TechnicianState extends State<Technician>{

  var Technician = FirebaseFirestore.instance.collection("craftsman").
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
                future: Technician.get(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return TechnicianList(
                              Technician : snapshot.data.docs[i],
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
class TechnicianList extends StatelessWidget{
  final Technician;
  final id;
  TechnicianList({super.key,
    this.Technician, this.id
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
              return view(crafts: Technician,);
            }));
          },
          child: Card(
            child: Row(
              children: [

                Expanded(
                  flex: 3,
                  child: ListTile(
                    title: Text("\n${Technician['name']}",),
                    subtitle: Text("\n${Technician['role']}"),
                    textColor: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListTile(
                    subtitle: Text("\n${Technician['phone']}",),
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
