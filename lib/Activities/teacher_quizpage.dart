import 'package:flutter/material.dart';
import 'package:quiz_test/Activities/choose_subject_teacher.dart';
import 'package:quiz_test/Activities/create_quiz.dart';
import 'package:quiz_test/Activities/play_quiz.dart';
import 'package:quiz_test/services/database.dart';

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
        backgroundColor: Colors.indigo,
        title: Text('QuizBox'),
        centerTitle: true,
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
        height: 150,
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
    );
  }
}
