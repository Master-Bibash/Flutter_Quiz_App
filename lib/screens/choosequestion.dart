import 'package:flutter/material.dart';
import 'package:quiz_application_1/common/colors.dart';
import 'package:quiz_application_1/common/images.dart';
import 'package:quiz_application_1/main.dart';
import 'package:quiz_application_1/screens/QuizScreen.dart';

class chooseQuestion extends StatefulWidget {
  const chooseQuestion({super.key});

  @override
  State<chooseQuestion> createState() => _chooseQuestionState();
}

class _chooseQuestionState extends State<chooseQuestion> {
  final _formKey = GlobalKey<FormState>();
  int number = 0;
  String errorMessage='';
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
                end: Alignment.bottomCenter),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.favorite, color: Colors.white),
                        label: Text("Like us"))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  win,
                  height: 350,
                ),
                SizedBox(
                  height: 20,
                ),
                headingText(
                    color: Colors.white,
                    size: 20,
                    text: "Enter the number of questions you want to answer? "),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                           final parsedValue=int.tryParse(value);
                           if (parsedValue!=null) {
                            number=parsedValue;
                            setState(() {
                              errorMessage='';
                            });
                             
                           }else{
                            setState(() {
                              errorMessage="Please enter a valid number";
                            });

                           }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a number';
                            }
                            final num = int.tryParse(value);
                            if (num == null || num <= 0) {
                              return 'Please enter a positive number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          
                          decoration: InputDecoration(
                          
                            labelText: "Enter a number",
                            labelStyle: TextStyle(color: Colors.amber),
                            
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.greenAccent))),
                        ),
                      ),
                    SizedBox(height: 15,),
                     
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuizScreen(number: number),
                                  ),
                                );
                              }
                            },
                            child: headingText(
                                color: Colors.white,
                                size: 20,
                                text: "Let's Go !!")),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
