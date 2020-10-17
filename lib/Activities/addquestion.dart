import 'package:flutter/material.dart';
import 'package:quiz_test/services/database.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  AddQuestion({this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {


  final _formKey = GlobalKey<FormState>();
  String question,option1,option2,option3,option4;
  bool _isLoading=false;

  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading=true;
      });
      Map<String,String>questionMap ={
         'question': question,
        'option1':option1,
        'option2':option2,
        'option3':option3,
        'option4':option4,
      };
      await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        setState(() {
          _isLoading=false;
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
      ):Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Question':null,
                decoration: InputDecoration(
                  hintText: 'Question',
                ),
                onChanged: (val){
                  question=val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Option1':null,
                decoration: InputDecoration(
                  hintText: 'Option1 (Correct Answer)',
                ),
                onChanged: (val){
                  option1=val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Option2':null,
                decoration: InputDecoration(
                  hintText: 'Option2',
                ),
                onChanged: (val){
                  option2=val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Option3':null,
                decoration: InputDecoration(
                  hintText: 'Option3',
                ),
                onChanged: (val){
                  option3=val;
                },
              ),

              SizedBox(height: 6,),

              TextFormField(
                validator: (val)=>val.isEmpty ? 'Enter Option4':null,
                decoration: InputDecoration(
                  hintText: 'Option4',
                ),
                onChanged: (val){
                  option4=val;
                },
              ),

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      uploadQuestionData();
                      Navigator.pop(context);
                    },
                    color: Colors.indigo,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    onPressed: () {
                      uploadQuestionData();
                    },
                    color: Colors.indigo,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add Question',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ],
              ),


              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
