import 'package:flutter/material.dart';

import 'package:letter/db.dart';
import 'package:letter/styedButton.dart';
import 'package:letter/theme.dart';
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

List Notes=[];

Future readData()async{
  List<Map>response=await sqlDB.read("NOTES");
  isloading=false;
print(Notes);
  Notes.addAll(response);

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
                  
                        itemCount: Notes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(color: AppColors.primaryAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text("${Notes[index]['title']}"),
                                subtitle: Text("${Notes[index]['content']}"),
                                trailing:  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                  children: [
                                     IconButton(onPressed: () async{
                                      Navigator.push(context, MaterialPageRoute(builder: 
                                      (context)=>noteedie(note: Notes[index]['content'],
                                      color: Notes[index]['color'],title: Notes[index]['title'],
                                      id: Notes[index]['id'],)));}, icon: Icon(Icons.edit)),
                                    
                                    IconButton(onPressed:
                                    ()async{await showDialog(context: context, builder: (ctx){
                                      return AlertDialog(
                                        title:  Styleheading("Delete"),
                                        content:  const Stylebody("Do you want to delete this note"),
                                        actions: [
                                          Row(
                                            children: [
                                    StyledButton(onPressed: ()async{
                                       int response =await sqlDB.delete("NOTES", "id=${Notes[index]['id']}");
                                       if(response>0){
                                         Notes.removeWhere((element)=>element['id']==Notes[index]['id']);
                                       }
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
                                       },
                                     child:  Text("Delete")),
                                                        
                                     StyledButton(onPressed: (){
                                       Navigator.pop(ctx);
                                     }, child: Text("cancel"))
                                  ],
                                ) ],
                                      );
                                     });},
                                        icon:  Icon(Icons.delete))
                                  ],
                                ),
                                        
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