import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:quiz_test/services/auth.dart';
import 'package:quiz_test/services/database.dart';
import 'package:random_string/random_string.dart';
class TopicRoute extends StatefulWidget {
  @override
  _TopicRouteState createState() => _TopicRouteState();
}

class _TopicRouteState extends State<TopicRoute> {
  List<String> topic = new List();
  String id='';

  /*//List<User> userDatabase = List();

  // User user= new User(appState.user);
  final FirebaseDatabase database = FirebaseDatabase.instance;
//  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;*/
  DatabaseService databaseService = new DatabaseService();

  /*@override
  void initState() {
    super.initState();

    databaseReference = database.reference().child("Users");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Topics of Interests"),
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          )
        ],
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(20.0)),
          CheckboxGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: const EdgeInsets.only(left: 12.0),
              labels: <String>[
                "Microprossesor",
                "Science",
                "Global",
                "Sports",
                "Business",
                "Gaming",
                "Entertainment",
                "Automobile",
                "Health",
              ],
              onSelected: (List<String> checked){
                topic=checked;
              }
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
          ),
          Text(
            "Click clear if you want to clear list or Submit to Save your interests",
            style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          ),
          RaisedButton(
            onPressed: () {
              topic.clear();
            },
            child: Text(
              "CLEAR",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          RaisedButton(
            onPressed: () => handleSubmit(context),
            child: Text(
              "SUBMIT",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        ],
      ),
    );
  }

  handleSubmit(BuildContext context) async {
    if(topic.length==0)
    {
      Flushbar(
        padding: EdgeInsets.all(10.0),
        borderRadius: 8,
        backgroundGradient: LinearGradient(
          colors: [Colors.red.shade500, Colors.orange.shade500],
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
        title: 'Something Missing!!!',
        message: 'You have not selected anything atleast choose one option',
        duration: Duration(seconds: 3),
      )..show(context);

    }
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StaticState.user.email.toString(), 1);
    String s=StaticState.user.email;
    s=s.substring(0,s.indexOf("@"));*/

    /*databaseReference.child(name).child("topicsofinterest").set({"toi":topic});
    databaseReference.*/
   //Map<String,List> lt = {'toi':topic};

    id=name+'??';

    Map<String,dynamic>quizMap = {
      'toi':topic,
    };

    await databaseService.addUserTopics(quizMap, id);


    //await databaseService.addUserTopics({"toi":topic});
    /*Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NewsMain()));*/

  }
}