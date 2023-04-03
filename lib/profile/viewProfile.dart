import 'package:flutter/material.dart';

class view extends StatefulWidget{

  final crafts;
  view ({Key? key, this.crafts}) : super (key: key);

  @override
  viewproduct createState() => viewproduct();
}

class viewproduct extends State<view>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("View"),
        leading: IconButton(icon:Icon (Icons.cancel,color: Colors.red.shade800,),onPressed: (){
          Navigator.of(context).pushReplacementNamed("HomeScreen");
        }) ,
      ),
      body:
      SingleChildScrollView(
        child: Container(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),

            Container(
                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text("Career : ${widget.crafts['Career']}",style: TextStyle(fontSize: 25),)),
            Container(
                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text("Phone : ${widget.crafts['phone']}",style: TextStyle(fontSize: 25),)),
            SizedBox(height: 30,),
            Center(child: IconButton(onPressed: (){

            }, icon:Icon(Icons.add,size: 50,),))

          ],),),
      ),
    );
  }
}