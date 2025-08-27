import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_application_1/AI_Chat_Screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key}); 
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> AiChatScreen()),
      );
    }
    );
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 50), 
              Image.asset("assets/images/RRB.png", width: 150),
              Text(
                "Hi, I am RRB - your AI companion at \nRR INSTITUTE OF MODERN TECHNOLOGY",
                textAlign: TextAlign.center,
              ),
            ],
          ),
       ),
);
}
}