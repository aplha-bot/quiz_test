import 'package:flutter/material.dart';
import 'package:quiz_test/Activities/addquestion.dart';
import 'package:quiz_test/services/auth.dart';
import 'package:quiz_test/services/database.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final List<String> subjects= ['Physics', 'Maths', 'Chemistry', 'English', 'Biology', 'Computer Science'];

  final _formKey = GlobalKey<FormState>();
  //String quizImageUrl, quizTitle, quizDescription,quizId;
  
  String quizId,quizTitle,quiImgUrl,quizTime,quizDescription,quizSubject;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading=false;
  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      /*Map<String,String>quizMap = {
        'quizId':quizId,
        'quizImgurl':quizImageUrl,
        'quizTitle': quizTitle,
        'quizDesc': quizDescription

      };*/
      /* await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading=false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddQuestion(
            quizId
          )));
        });
      });*/

      await databaseService.addQuiz2(
          quizId,quiImgUrl, quizTime, quizTitle, quizDescription).then((value){
            setState(() {
              _isLoading=false;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddQuestion(
                  quizId: quizId,
              )));
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('QuizBox'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ):
      Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Image Url':null,
                decoration: InputDecoration(
                  hintText: 'Image Url',
                ),
                onChanged: (val){
                  quiImgUrl=val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Quiz Time':null,
                decoration: InputDecoration(
                  hintText: 'Quiz Time',
                ),
                onChanged: (val){
                  quizTime=val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Quiz Title':null,
                decoration: InputDecoration(
                  hintText: 'Quiz Title',
                ),
                onChanged: (val){
                  quizTitle=val;
                },
              ),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Quiz Description':null,
                decoration: InputDecoration(
                  hintText: 'Quiz Description',
                ),
                onChanged: (val){
                  quizDescription=val;
                },
              ),
              Spacer(),
              RaisedButton(
                onPressed: () {
                  createQuizOnline();
                },
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create Quiz',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
