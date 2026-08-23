import 'package:flutter/material.dart';
import 'package:letter/bar.dart';
import 'package:letter/contcard.dart';
import 'package:letter/db.dart';
import 'textStyle.dart';
import 'letter.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


Db sqlDB=Db();

Future<List<Map>> readData()async{
  List<Map>response=await sqlDB.readData("SELECT * FROM NOTES");
  return response;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title:Styletitle('Notes') ,
        
        ),
        
        body: Container(
          child: ListView(
            children: [

              FutureBuilder( builder: (builderContext,AsyncSnapshot<List<Map>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Text("${snapshot.data![index]}");
                    } ,
                  );
                }
return Center(child: CircularProgressIndicator(),);
              }, future: readData(),)
            ],
          ),
        ),
           
        );
  
  }
}