import 'package:flutter/material.dart';

class AppColors {

  static Color primaryColor = const Color.fromARGB(255, 200, 237, 255);
  static Color primaryAccent = const Color.fromARGB(255, 239, 199, 119);
static Color secndryColor = const Color.fromARGB(255, 125, 195, 230);
static Color secndryAccent = const Color(0xFFFFF7EB);

static Color titleColor =const Color.fromARGB(255, 0, 0, 0);

static Color textColor =const Color.fromARGB(255, 169, 137, 74);




}

ThemeData primaryTheme =ThemeData(

  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor,
  
  ),

  scaffoldBackgroundColor: AppColors.secndryAccent,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secndryColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),


  

  cardTheme: CardThemeData(
    color: AppColors.secndryColor.withOpacity(.5),
  surfaceTintColor: Colors.transparent, 
  shadowColor: Colors.transparent,
  margin: const EdgeInsets.only(bottom:16)),






);