import 'package:flutter/material.dart';
import 'package:letter/db.dart';
import 'package:letter/theme.dart';

class Contcard extends StatefulWidget {
  const Contcard({super.key});


  @override
  State<Contcard> createState() => _ContcardState();
}

class _ContcardState extends State<Contcard> {

Db sqlDB= Db();

  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(
            color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(25),
          
          ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children:[
    IconButton(onPressed: () async{
      int response =await sqlDB.updateData("UPDATE NOTES SET ");
    }, icon: Icon(Icons.edit)),
     IconButton(onPressed: ()async{
            int response =await sqlDB.deleteData("DELETE FROM NOTES WHERE 'id'= ");

     }, icon:  Icon(Icons.delete))
          ]),
          TextButton(
            child:Card(child: Text(
              "NOTE"
            ),)
             , onPressed: ()async{
             
              List<Map>response=await sqlDB.readData("SELECT * FROM NOTES ");
             },
          
          ),
        ],
      ),
    );
  }
}