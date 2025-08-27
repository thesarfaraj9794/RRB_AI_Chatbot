
//import 'package:flutter_application_1/AI_Chat_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_application_1/splash_screen.dart';

const apiKey ='';

void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  runApp(
    MaterialApp(
      home:Splashscreen(),
       debugShowCheckedModeBanner: false,
      
      
)
);
}


