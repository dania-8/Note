import 'package:flutter/material.dart';
import 'package:letter/bar.dart';
import 'package:letter/contcard.dart';
import 'package:letter/create.dart';
import 'package:letter/db.dart';
import 'package:letter/styedButton.dart';
import 'textStyle.dart';
import 'note_edie.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

bool isloading =true;


Db sqlDB=Db();

List notes=[];

Future readData()async{
  List<Map>response=await sqlDB.readData("SELECT * FROM NOTES");
  isloading=false;
  notes.addAll(response);
  if(this.mounted){
    setState(() { 
    });
  }

}

@override
void initState(){
  readData();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title:Styletitle('Notes') ,
        
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
Navigator.of(context).pushNamed('create');},
child: Icon(Icons.add),),
        body: isloading==true?
        Center(child:Text('Loading...')):
        
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
              
                   ListView.builder(
                        itemCount: notes.length,
                      
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${notes[index]['title']}"),
                            subtitle: Text("${notes[index]['content']}"),
                            trailing:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                   IconButton(onPressed: () async{
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>noteedie(note: notes[index]['note'],
                                    color: notes[index]['color'],title: notes[index]['title'],id: notes[index]['id'],)));}, icon: Icon(Icons.edit)),
                                  
                                  IconButton(onPressed:
                                  
                                   ()async{await showDialog(context: context, builder: (ctx){
                                    return AlertDialog(
                                      title:  Styleheading("Delete"),
                                      content:  const Stylebody("Do you want to delete this note"),
                                      actions: [
                                        Row(
                                          children: [
                                  StyledButton(onPressed: ()async{
                                     int response =await sqlDB.deleteData("DELETE FROM NOTES WHERE 'id'='${notes[index]['id']}' ");
                                     if(response>0){
                                      notes.removeWhere((element)=>element['id']==notes[index]['id']);
                                     }
                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
                                     },
                                   child:  Text("Delete")),
                                                      
                                   StyledButton(onPressed: (){
                                     Navigator.pop(ctx);
                                   }, child: Text("cancel"))
                                ],
                              )
                                                      ],
                                    );
                                   });},
                                      icon:  Icon(Icons.delete))
                                ],
                              ),
                            ),
                                    
                          );
                        } ,
                      )
                   
                ],
              ),
            ),
          ],
        ),
           
        );
  
  }
}