import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: Column(
    children: [
      AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Color.fromARGB(255, 0, 191, 200),
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Center(
          child: Text(
            'Home Page',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 191, 200),
              fontSize: 35,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top:10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   BoxStyle(icon: Icons.calendar_month , text: 'Book Appointment', page:'none'),
                    BoxStyle(icon: Icons.vaccines , text: 'View Prescription', page:'none'),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoxStyle(icon: Icons.medical_information_sharp , text: 'Book Session', page:'none'),
                    BoxStyle(icon: Icons.medication_liquid_rounded , text: 'Test Result' , page:'none'),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoxStyle(icon: Icons.feed_sharp , text: 'Service Evaluation', page:'none' ),
                    BoxStyle(icon: Icons.email , text: 'Quick Chat' , page: '/chat.dart',),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ],
    ),
    );
  }
}
