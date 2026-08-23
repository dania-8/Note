import 'package:flutter/material.dart';
import 'package:letter/db.dart';
import 'package:letter/home.dart';
import 'package:letter/textStyle.dart';
import 'package:letter/theme.dart';

class noteedie extends StatefulWidget {
  final note;
  final title;
  final id;
  final color;

  const noteedie({super.key, this.note, this.title, this.id, this.color,
  
  });

  @override
  State<noteedie> createState() => _noteedieState();
}

class _noteedieState extends State<noteedie> {
  
Db sqlDB=Db();
 GlobalKey<FormState>formstate=GlobalKey();
  TextEditingController note=TextEditingController();
  TextEditingController title=TextEditingController();
  TextEditingController color=TextEditingController();
  @override
  void initState(){
    note.text=widget.note;
    title.text=widget.title;
    color.text=widget.color;

super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note'),),

      body: Container(
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
         int response= await sqlDB.update("NOTES", {
         "content":"${note.text}",
        "title":"${title.text}",
        "color":"${color.text}"}, "id=${widget.id}");
         print(response);
if(response > 0){
  Navigator.pushReplacement(context,
  MaterialPageRoute(builder: (context) => const Home()));
}
        
        },
      child: Stylebody("Save Edit"),)
    ],
    )
    )
  ],),
) ,

    );
  }
}