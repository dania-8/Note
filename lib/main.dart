import 'package:flutter/material.dart';
import 'package:letter/create.dart';
import 'package:letter/home.dart';
import 'theme.dart';
void main() async{
WidgetsFlutterBinding.ensureInitialized();



  runApp(
    MaterialApp( theme: primaryTheme,
      home:
       Home(),
       routes: {
        "create":(context)=>Create()
       },
       ));


}

