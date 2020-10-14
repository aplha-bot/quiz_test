import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_test/services/auth.dart';

class DatabaseService {
  Future<void> addUserTopics(Map quizData, String id) async {
    await Firestore.instance
        .collection('Users')
        .document(name + '??')
        .collection(name)
        .document(id)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection('Quiz')
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future <void>addQuiz2(String quizId,String sub,String imgUrl ,String time, String title, String des) async
  {
    await Firestore.instance.collection(sub)
        .doc(quizId)
        .setData({
      'imgUrl': imgUrl,
      'time': time,
      'uid': quizId,
      'description': des,
      'title': title })
        .catchError((e){print(e.toString());});
  }

  Future<void> addQuestionData(Map questionData, String quizId,String quizSubject) async {
    await Firestore.instance
        .collection(quizSubject)
        .document(quizId)
        .collection('QNA')
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizzesData() async {
    return await Firestore.instance.collection('English').snapshots();
  }

  getQuizData(String quizId) async {
    return await Firestore.instance
        .collection('English')
        .document(quizId)
        .collection('QNA')
        .getDocuments();
  }
}
