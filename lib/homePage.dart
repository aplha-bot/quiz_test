import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_test/Activities/student_home.dart';
import 'package:quiz_test/Activities/teacher_home.dart';
import 'package:quiz_test/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('QuizBox'),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue[400]],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                      return TeacherHome();
                    })));
                  },
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Log in as Teacher',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                SizedBox(height: 15,),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      showSpinner=true;
                    });

                    try{
                      signInWithGoogle().whenComplete(() =>
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                            return StudentHome();
                          })));
                    }catch(e){
                      print(e);
                    }


                    setState(() {
                      showSpinner=false;
                    });
                  },
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Log in as Student',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
