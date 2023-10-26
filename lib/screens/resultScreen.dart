import 'package:flutter/material.dart';
import 'package:quiz_application_1/common/colors.dart';
import 'package:quiz_application_1/main.dart';

class ResultQuiz extends StatefulWidget {
  const ResultQuiz({
    Key? key,
    required this.result,
    required this.questions,
  }) : super(key: key);
  final int result;
  final int questions;

  @override
  State<ResultQuiz> createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   congratulationsImage, // Add an image to congratulate the user.
              //   width: 200,
              //   height: 200,
              // ),
              SizedBox(height: 20),
              Text(
                "Quiz Completed",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You scored ${widget.result} out of ${widget.questions} questions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuizApp(),));
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.pink
                ),
                child: Text("Try Again !",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
