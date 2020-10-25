import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_test/services/auth.dart';

import '../constants.dart';
import '../home_page.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Leader Board',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 6,
        actions: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(700.0),
            ),
            color: Colors.grey[300],
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(700.0),
              ),
              icon: Icon(Icons.list,color: Colors.black45,size: 28,),
              onSelected: choiceAction,
              offset: Offset(0, 100),
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
