import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_test/Activities/choose_subject_teacher.dart';
import 'package:quiz_test/Activities/create_quiz.dart';
import 'package:quiz_test/Activities/play_quiz.dart';
import 'package:quiz_test/constants.dart';
import 'package:quiz_test/services/auth.dart';
import 'package:quiz_test/services/database.dart';

import '../home_page.dart';

class TeacherQuiz extends StatefulWidget {
  @override
  _TeacherQuizState createState() => _TeacherQuizState();
}

class _TeacherQuizState extends State<TeacherQuiz> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();


  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context,snapshot){
          return snapshot.data == null ? Container() :
          ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
              return QuizTile(
                imgUrl: snapshot.data.documents[index].get("imgUrl"),
                title: snapshot.data.documents[index].get("title"),
                desc: snapshot.data.documents[index].get("description"),
                quizId: snapshot.data.documents[index].get("uid"),
              );
              });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizzesData(
      quizSubject
    ).then((val){
      setState(() {
        quizStream=val;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 6,
        actions: [
          /*Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500.0),
            ),
            child: ClipOval(
              child: Material(
                color: Colors.transparent, // button color
                child: InkWell(
                  splashColor: Colors.grey, // inkwell color
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.list,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ),*/
          Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(700.0),
            ),
            color: Colors.grey[300],
            child: PopupMenuButton<String>(
              icon: Icon(Icons.list,color: Colors.black45,size: 28,),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      children: [
                        Icon(Icons.call_missed_outgoing,color: Colors.black45,),
                        SizedBox(width: 15,),
                        Text(choice,
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return CreateQuiz();
          }));
        },
      ),
    );
  }
  void choiceAction(String choice){
   if(choice == Constants.SignOut)
     {
       signOutGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
         return HomePage2();
       })));
     }
  }

}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;
  QuizTile({@required this.imgUrl,@required this.title,@required this.desc,@required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context)
          => PlayQuiz(
            quizId: quizId,
          )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 125,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Stack(
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(8),
                 child: Image.network(imgUrl,width: MediaQuery.of(context).size.width-48,fit: BoxFit.cover,)),
             Container(
               decoration: BoxDecoration(
                 color: Colors.black26,
                 borderRadius: BorderRadius.circular(8),
               ),
               alignment: Alignment.center,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(title,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),),
                   SizedBox(height: 6,),
                   Text(desc,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),),
                 ],
               ),
             )
           ],
          ),
        ),
      ),
    );
  }
}
