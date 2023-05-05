import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                      height: 80.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BoxStyle2(icon: Icons.edit_calendar , text: 'Users Appointments', page:'none'),
                        BoxStyle2(icon: Icons.calendar_month , text: 'Available Dates', page:'none'),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BoxStyle2(icon: Icons.group , text: 'Manage Users', page:'none'),
                        BoxStyle2(icon: Icons.edit_note , text: 'Users Evaluations' , page:'none'),
                      ],
                    ),
                      ],
                    ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
