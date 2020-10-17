import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_test/Activities/choose_subject_teacher.dart';
import 'package:quiz_test/Activities/student_home.dart';
import 'package:quiz_test/Activities/teacher_home.dart';
import 'package:quiz_test/animations/fade_animations.dart';
import 'package:quiz_test/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool _loading = false;
  void initState() {
    quizSubject = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _loading == true
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset("images/main_top.png"),
                  width: size.width * 0.5,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("images/login_bottom.png"),
                  width: size.width * 0.6,
                ),
                Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: FadeAnimation(
                    1.2,
                    Text(
                      'QuizBox',
                      style: TextStyle(
                        letterSpacing: 7,
                        fontFamily: 'Montserrat',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 120,
                    width: 500,
                    child: Divider(
                      color: Colors.black,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 280, 0, 0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        1.3,
                        Text(
                          "I'm using QuizBox...",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 330, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        signInWithGoogle().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return ChooseSubjectsTeacher();
                          }));
                          setState(() {
                            _loading = false;
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(),
                      height: 70,
                      child: Card(
                        color: Colors.indigo,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: ListTile(
                            title: Text(
                              '   As Teacher',
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              child: ClipRect(
                                  child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('images/clip-734.png'),
                              )),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 410, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        signInWithGoogle().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return StudentHome();
                          }));
                          setState(() {
                            _loading = false;
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      height: 70,
                      child: Card(
                        color: Colors.orangeAccent,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: ListTile(
                            title: Text(
                              '      As Student',
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: ClipRect(
                                child: Image.asset(
                                  'images/flame.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
