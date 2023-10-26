// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:quiz_application_1/common/colors.dart';
import 'package:quiz_application_1/common/images.dart';
import 'package:quiz_application_1/screens/choosequestion.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
      theme: ThemeData(
        fontFamily: "quick",
      ),
      title: "Demo",
    );
  }
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [blue, darkblue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(onPressed: (){},
                 icon: Icon(CupertinoIcons.xmark,
                 color: Colors.white,
                 size: 25,)),
              ),
              Image.asset(quiz,height: 400,width: double.infinity,),
              SizedBox(height: 2,),
            normalText(color: lightgrey, siz: 18, text: "Welcome to our"),
            headingText(color: Colors.white,
             size: 32, text: "Quiz App"),
             SizedBox(height: 4,),

             normalText(color: lightgrey,
              siz: 18, text: "Do you wanna know ,how smart you are ? Here let's check it out !"),
              SizedBox(height: 20,),
              Spacer(),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: StadiumBorder()
                    
                  ),
                  
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => chooseQuestion(),));
              
                },
                 child: Text("Continue",style: TextStyle(fontSize: 20,color: Colors.blue[700],fontWeight: FontWeight.w500,
                 ),
                
                 
                 )),
              ),
  
            ],
          ),
        ),
      ),
    );
  }
}

class headingText extends StatelessWidget {
  const headingText({
    Key? key,
    required this.color,
    required this.size,
    required this.text,
  }) : super(key: key);
  final Color color;
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
            fontFamily: "quick_semi",
      color: color,fontSize: size,),);
  }
}

class normalText extends StatelessWidget {
  const normalText({
    Key? key,
    required this.color,
    required this.siz,
    required this.text,
  }) : super(key: key);
  final Color color;
  final double siz;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      fontFamily: "quick_semi",
      fontSize: siz,
      color: color
    ),);
  }
}
