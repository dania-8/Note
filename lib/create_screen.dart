import 'package:flutter/material.dart';
import 'package:letter/db.dart';
import 'package:letter/home.dart';
import 'package:letter/textStyle.dart';
import 'package:letter/theme.dart';

class Create extends StatefulWidget {
  final profileId;
  const Create({super.key, this.profileId});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

Db sqlDB=Db();

  GlobalKey<FormState>formstate=GlobalKey();
  TextEditingController note=TextEditingController();
  TextEditingController title=TextEditingController();
  TextEditingController color=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("New Note"),),
body:Container(
  padding: EdgeInsets.all(10),
  child: ListView(children: [
    Form(
      key: formstate,
      child:Column(
    children: [
      TextFormField(controller: title,
      decoration: InputDecoration(
        hintText: "Title"
      ),),
        TextFormField(controller: note,
      decoration: InputDecoration(
        hintText: "Note"
      ),),
TextFormField(controller: color,
      decoration: InputDecoration(
        hintText: "Color"
      ),),

      SizedBox(height: 20,),

      MaterialButton(
        textColor: Colors.black,
        color: AppColors.secndryColor,
        onPressed:()async{
         int response= await sqlDB.insert("NOTES", {
         "content":"${note.text}",
        "title":"${title.text}",
        "color":"${color.text}"});
         print(response);
if(response>0){
  print("ok");
  Navigator.pushReplacement( context,
            MaterialPageRoute(builder: (context) => const Home()));
}
        
        },
      child: Stylebody("Save"),)
    ],
    )
    )
  ],),
) ,

    );
  }
}