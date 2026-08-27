import 'package:flutter/material.dart';
import 'package:letter/create.dart';
import 'package:letter/home.dart';
import 'package:letter/loading.dart';
import 'package:letter/login.dart';
import 'theme.dart';
void main() async{
WidgetsFlutterBinding.ensureInitialized();



  runApp(
    MaterialApp( theme: primaryTheme,
      home:
       AppEntryGate(),
       routes: {
        "create":(context)=>Create()
       },
       ));


}

