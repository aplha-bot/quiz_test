import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_test/homePage.dart';

import 'home_page.dart';

class Pseudo extends StatefulWidget {
  @override
  _PseudoState createState() => _PseudoState();
}

class _PseudoState extends State<Pseudo> with TickerProviderStateMixin {
  PageController _pageController;

  AnimationController rippleController;
  AnimationController scaleController;

  Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
        initialPage: 0
    );

    rippleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    );

    scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: HomePage2()));
      }
    });

    rippleAnimation = Tween<double>(
        begin: 80.0,
        end: 90.0
    ).animate(rippleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rippleController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        rippleController.forward();
      }
    });

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(scaleController);

    rippleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(image: 'images/pro.png'),
        ],
      ),
    );
  }

  Widget makePage({image}) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Enhance Your Quizzing Skills',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Montserrat',
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: rippleAnimation,
                    builder: (context, child) => Container(
                      width: rippleAnimation.value,
                      height: rippleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(.4)
                        ),
                        child: InkWell(
                          onTap: () {
                            scaleController.forward();
                          },
                          child: AnimatedBuilder(
                            animation: scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: scaleAnimation.value,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.indigo
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}