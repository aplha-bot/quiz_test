import 'package:flutter/material.dart';
import 'package:quiz_test/Activities/teacher_quizpage.dart';
import 'package:quiz_test/homePage.dart';
import 'package:custom_navigator/custom_scaffold.dart';

class Results extends StatefulWidget {
  final int correct,incorrect,total;

  Results({@required this.correct,@required this.incorrect,@required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Result'),
        centerTitle: true,
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            //child: Icon(Icons.search),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}\n",style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),),
              SizedBox(height: 8,),
              Text("You answered ${widget.correct} answers correctly \n and"
                  "\n${widget.incorrect} answers incorrectly",style: TextStyle(
                fontSize:20,color: Colors.black
              ),textAlign: TextAlign.center,),
              SizedBox(height: 14,),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Go to home',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
             /* CustomScaffold(
                scaffold: Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text("Home"),
                        backgroundColor: Colors.deepPurple,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        title: Text("Quizzes"),
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.score),
                        title: Text("LeaderBoard"),
                        backgroundColor: Colors.green,
                      ),
                    ],
                    *//*type: BottomNavigationBarType.shifting,
                    onTap: _onTap,
                    key: _navigatorKey,*//*
                  ),
                ),
                children:<Widget> [
                  HomePage(),
                  TeacherQuiz(),
                  HomePage(),
                ],
              ),
              SizedBox(height: 30,),*/
            ],
          ),
        ),
      ),
    );
  }
}



