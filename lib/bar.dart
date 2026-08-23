import 'package:flutter/material.dart';
import 'profile.dart';
import 'create.dart';
import 'login.dart';
class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        IconButton(onPressed: (){
          Navigator.push( context,
            MaterialPageRoute(builder: (context) => const Profile()));
        }, icon: Icon(Icons.person))  ,
        
        IconButton(onPressed: (){
          Navigator.push( context,
            MaterialPageRoute(builder: (context) =>  Create()));
        }, icon: Icon(Icons.add)),
        
        IconButton(onPressed: (){
          Navigator.push( context,
            MaterialPageRoute(builder: (context) =>  Login()));
        }, icon: Icon(Icons.switch_account_rounded)),
        ],
        ),
      ),
    );
  }
}