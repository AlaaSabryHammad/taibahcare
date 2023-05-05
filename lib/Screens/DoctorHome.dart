import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
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
                        BoxStyle2(icon: Icons.list , text: 'View Appointments', page:'none'),
                        BoxStyle2(icon: Icons.medication, text: 'Manage Prescription', page:'none'),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BoxStyle2(icon: Icons.compare_arrows_sharp , text: 'Refer Patients', page:'none'),
                        BoxStyle2(icon: Icons.perm_contact_cal_sharp , text: 'Patients Profile' , page:'none'),
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
