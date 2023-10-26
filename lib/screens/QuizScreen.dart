// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:quiz_application_1/common/colors.dart';
import 'package:quiz_application_1/common/images.dart';
import 'package:quiz_application_1/main.dart';
import 'package:quiz_application_1/screens/api%20service/api_service.dart';
import 'package:quiz_application_1/screens/resultScreen.dart';

class QuizScreen extends StatefulWidget {
  final int number;
  const QuizScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  String? decodeHtmlEntities(String text) {
    final document = parseFragment(text);
    return document.text;
  }

  int seconds = 60;
  late Timer timer;
  var currentQuestionIndex = 0;
  late Future quiz;
  var isLoaded = false;
  var optionsList = [];
  int correctAnser = 0;
  int points = 0;
  late List<Color> optionsColor;
  String correctAnswer = "";
  String correctAnswerForCurrentQuestion = "";
  List<dynamic>? data; // Declare data as a class-level variable
  bool _isMounted = false;

  resetColors() {
    setState(() {
      optionsColor = List.filled(optionsList.length, Colors.white);
    });
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isMounted) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            timer.cancel(); // Pause the timer

            if (correctAnswer.isEmpty) {
              // User hasn't answered, show the answer for the current question
              isLoaded = false;
              correctAnswer = correctAnswerForCurrentQuestion;
              optionsColor[optionsList.indexOf(correctAnswer)] = Colors.green;

              Future.delayed(Duration(seconds: 2), () {
                if (_isMounted) {
                  // Check if the widget is still mounted
                  setState(() {
                    correctAnswer = "";
                    seconds = 60; // Reset the timer
                    currentQuestionIndex++; // Move to the next question
                    resetColors();
                    startTimer(); // Start the timer for the next question
                  });
                }
              });
            } else {
              // User has answered the question, proceed to the next question
              if (currentQuestionIndex < data!.length - 1) {
                if (_isMounted) {
                  setState(() {
                    isLoaded = false;
                    correctAnswer = correctAnswerForCurrentQuestion;
                    optionsColor[optionsList.indexOf(correctAnswer)] =
                        Colors.green;
                    Future.delayed(Duration(seconds: 2), () {
                      if (_isMounted) {
                        setState(() {
                          correctAnswer = "";
                          seconds = 60; // Reset the timer
                          currentQuestionIndex++; // Move to the next question
                          resetColors();
                          startTimer(); // Start the timer for the next question
                        });
                      }
                    });
                  });
                }
              } else if (currentQuestionIndex == data!.length - 1) {
                // The user is on the last question, navigate to the result screen
                if (_isMounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultQuiz(
                        result: correctAnser,
                        questions: data!.length,
                      ),
                    ),
                  );
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    _isMounted = true;
    // TODO: implement initState
    quiz = getQuiz(widget.number);
    optionsColor = List<Color>.generate(
        5, (index) => Colors.white); // Initialize optionsColor
    correctAnswerForCurrentQuestion =
        ""; // Reset correctAnswerForCurrentQuestion

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _isMounted = false;
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String replaceHtmlEntities(String text) {
      final unescape = HtmlUnescape();
      return unescape.convert(text);
    }

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
                    end: Alignment.bottomCenter),
              ),
              child: FutureBuilder(
                future: quiz,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data["results"];
                    var currentData =
                        snapshot.data["results"][currentQuestionIndex];

                    if (isLoaded == false) {
                      correctAnswerForCurrentQuestion = replaceHtmlEntities(
                          data![currentQuestionIndex]['correct_answer']);
                      optionsList =
                          data![currentQuestionIndex]["incorrect_answers"];
                      optionsList.add(correctAnswerForCurrentQuestion);
                      optionsList.shuffle();
                      optionsColor = List<Color>.generate(
                          optionsList.length, (index) => Colors.white);

                      isLoaded = true;
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.xmark,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  normalText(
                                      color: Colors.white,
                                      siz: 24,
                                      text: '${seconds}'),
                                  SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator(
                                        value: seconds / 60,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ))
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_outline_outlined),
                                    label: normalText(
                                        color: Colors.white,
                                        siz: 15,
                                        text: "Like")),
                              )
                            ],
                          ),
                          Image.asset(
                            ideas,
                            width: double.infinity,
                            height: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: normalText(
                                color: lightgrey,
                                siz: 18,
                                text:
                                    "Question ${currentQuestionIndex + 1} of ${data!.length}"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          correctAnswer.isNotEmpty
                              ? normalText(
                                  color: Colors.white,
                                  siz: 20,
                                  text:
                                      "Correct answer is $correctAnswerForCurrentQuestion",
                                )
                              : SizedBox(
                                  height: 5,
                                ),
                          normalText(
                            color: Colors.white,
                            siz: 20,
                            text: replaceHtmlEntities(
                                data![currentQuestionIndex]['question']),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: optionsList.length,
                            itemBuilder: (context, index) {
                              var answer = decodeHtmlEntities(
                                  data![currentQuestionIndex]
                                      ['correct_answer']);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer ==
                                        optionsList[index].toString()) {
                                      if (index < optionsColor.length) {
                                        optionsColor[index] = Colors.green;
                                        correctAnser++;
                                      }
                                      points = points + 10;
                                    } else {
                                      if (index < optionsColor.length) {
                                        optionsColor[index] = Colors.red;
                                        answer = optionsList[index].toString();
                                        correctAnswer = answer.toString();
                                      }
                                    }

                                    if (currentQuestionIndex <
                                        data!.length - 1) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        isLoaded = false;
                                        currentQuestionIndex++;
                                        resetColors();
                                        correctAnswer = "";
                                        seconds = 60;
                                        startTimer();
                                      });
                                    } else if (currentQuestionIndex ==
                                        data!.length - 1) {
                                      // The user is on the last question, navigate to the result screen
                                      timer.cancel();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ResultQuiz(
                                                  result: correctAnser,
                                                  questions: data!.length)));
                                    }
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.center,
                                  width: size.width - 100,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: (index < optionsColor.length)
                                        ? optionsColor[index]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: headingText(
                                    color: blue,
                                    size: 18,
                                    text: optionsList[index],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white70),
                    ));
                  }
                },
              ))),
    );
  }
}
