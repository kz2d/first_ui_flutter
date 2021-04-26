import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_ui/constants.dart';
import 'package:first_ui/pages/Item_card.dart';
import 'package:first_ui/pages/main.dart';
import 'package:first_ui/test_data.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: kPrimary,accentColor: Colors.white,
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  primary: kPrimaryOposite,
                  backgroundColor: kPrimary,
                  alignment: Alignment.center,
                  elevation: 0,
                  minimumSize: Size(80, 40),
                  side: BorderSide(color: kPrimaryOposite, width: 1))),
          textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.white, fontSize: 10),
              headline2: TextStyle(color: Colors.white, fontSize: 18))),
      home: MainPage(),
    );
  }
}



class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Center(
          child: TextButton(
            onPressed: () {},
            child: Text('lllllll'),
          ),
        ),
      ),
      bottomNavigationBar: Animator(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 60)),
        duration: Duration(milliseconds: 900),
        cycles: 0,
        builder: (_, animatorState, __) => Transform(
          transform: Matrix4.translationValues(
              animatorState.value.dx, animatorState.value.dy, 0),
          child: BottomAppBar(
            color: Colors.black,
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 210,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 28,
                      ),
                      Icon(
                        Icons.note_add_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
    );
  }
}
