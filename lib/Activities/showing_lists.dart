import 'package:flutter/material.dart';
import 'package:quiz_test/services/database.dart';

class ShowingList extends StatefulWidget {
  @override
  _ShowingListState createState() => _ShowingListState();
}

class _ShowingListState extends State<ShowingList> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    databaseService.getRegisterData(
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
      body: StreamBuilder(
        stream: quizStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  return Text(
                    '${snapshot.data.documents.length}',
                  );
                });
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
