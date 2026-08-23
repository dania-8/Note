import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class Styleheading extends StatelessWidget {
  const Styleheading(this.text,{super.key});

final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 25,color:AppColors.textColor,));
  }
}
class Styletitle extends StatelessWidget {
  const Styletitle(this.text,{super.key});

final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.openSans(fontSize: 20,color: AppColors.titleColor,fontWeight:FontWeight.bold ),);
  }
}
class Stylebody extends StatelessWidget {
  const Stylebody(this.text,{super.key});

final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.lato
(fontSize: 15,color: AppColors.textColor),);
  }
}