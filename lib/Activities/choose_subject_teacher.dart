import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_test/Activities/teacher_home.dart';
import 'package:quiz_test/Activities/teacher_quizpage.dart';
String quizSubject='';

class ChooseSubjectsTeacher extends StatefulWidget {
  @override
  _ChooseSubjectsTeacherState createState() => _ChooseSubjectsTeacherState();
}

class _ChooseSubjectsTeacherState extends State<ChooseSubjectsTeacher> {
  final List<String> subjects= ['Physics', 'Maths', 'Chemistry', 'English', 'Biology', 'Computer Science'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: [
           Positioned(
             top: 0,
             right: 0,
             child: Image.asset("images/top_right_1.png",height: size.height*0.325,),

           ),
           Center(
             child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text("Choose Subject",
                style: GoogleFonts.montserrat(
                  fontSize: 35,
                  color: Colors.indigo,
                )
                ,),
              Image.asset("images/choose.png",height: size.height*0.5,),
              SizedBox(height: 50,),
              Container(
                //height: size.width*0.25,
                width: size.width*0.8,
                child: DropdownButtonFormField(
                  items: subjects.map((sub){
                    return DropdownMenuItem(
                      value: sub,
                      child: Text(sub),
                    );
                  }).toList(),
                  hint: Text(' Subjects',style: GoogleFonts.montserrat(),),
                  onChanged: (val) =>setState((){
                    quizSubject = val;
                  }),
                ),
              ),
              SizedBox(height: 25,),
          ],
        ),
           ),
      ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.indigo,
        onPressed: (){
          if(quizSubject==''){
            Flushbar(
              padding: EdgeInsets.all(10.0),
              borderRadius: 8,
              backgroundGradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.grey],
                stops: [0.5, 1],
              ),
              boxShadows: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
              forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
              title: 'Something Missing!!',
              message: 'You have not selected anything atleast choose one option',
              duration: Duration(seconds: 3),
            )..show(context);
          }else{
            try{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return TeacherQuiz();
              }));
            }catch(e){
              print(e);
            }

          }
        },
        elevation: 0.7,
      ),
    );
  }
}
