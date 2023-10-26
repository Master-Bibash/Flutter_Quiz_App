import 'dart:convert';

import 'package:http/http.dart'as http;

getQuiz(int num) async{


  var link="https://opentdb.com/api.php?amount=${num}";

  var res=await http.get(Uri.parse(link));
  if (res.statusCode==200) {
    var data=jsonDecode(res.body.toString());
    print("data is loaded");
    return data;
    
  }else{
    print("error has come");
  }
}