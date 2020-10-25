import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/Activities/create_quiz.dart';
import 'package:quiz_test/Activities/leader_board.dart';
import 'package:quiz_test/Activities/teacher_home.dart';
import 'package:quiz_test/Activities/teacher_profile.dart';
import 'package:quiz_test/Activities/teacher_quizpage.dart';

class BottomNaviHome extends StatefulWidget {
  @override
  _BottomNaviHomeState createState() => _BottomNaviHomeState();
}

class _BottomNaviHomeState extends State<BottomNaviHome> {

  //List<Widget> _pageRoutes = [TeacherProfile(),TeacherHome(),LeaderBoard()];
  int pageIndex = 0;
  final TeacherProfile _teacherProfile = TeacherProfile();
  final TeacherQuiz _teacherQuiz = TeacherQuiz();
  final CreateQuiz _createQuiz = CreateQuiz();
  final LeaderBoard _leaderBoard = LeaderBoard();


  Widget _showPage =  new TeacherProfile();

  Widget _pageChooser(int page)
  {
    switch (page)
    {
      case 0:
        return _teacherProfile;
        break;

      case 1:
        return _teacherQuiz;
        break;

      case 2:
        return _createQuiz;
        break;

      default:
        return _leaderBoard;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white70,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(
          milliseconds: 390,
        ),
        height: 50,
        items: [
          Icon(Icons.person,size: 20,),
          Icon(Icons.home,size: 20,),
          Icon(Icons.add_to_photos,size: 20,),
          Icon(Icons.score,size: 20,),
        ],
        onTap: (index){
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
      body: Center(
        child: _showPage,
      ),
    );
  }
}
