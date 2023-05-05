import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Additional extends StatefulWidget {
  const Additional(
      {super.key,
      required this.fName,
      required this.lName,
      required this.age,
      required this.status});
  final String fName;
  final String lName;
  final String age;
  final String status;
  @override
  _AdditionalState createState() => _AdditionalState();
}

class _AdditionalState extends State<Additional> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;
  String? chronic;
  String? allergies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/taibah.png'),
                  ),
                ),
              ),
              const Text(
                'Continue your registration',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 191, 200),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: ' Confirm your password',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  allergies = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your allergies',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  chronic = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Any chronic diseases',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                  text: 'Register',
                  press: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email!, password: password!);
                      firebaseFirestore
                          .collection('patients')
                          .doc(credential.user!.uid)
                          .set({
                        'patientId': credential.user!.uid,
                        'firstName': widget.fName,
                        'lastName': widget.lName,
                        'age': widget.age,
                        'social': widget.status,
                        'email': email,
                        'password': password,
                        'allergies': allergies,
                        'chronicDiseases': chronic
                      });
                      Navigator.pushNamed(context, '/homepage');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        var snackBar = const SnackBar(
                            content:
                                Text('The password provided is too weak.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'email-already-in-use') {
                        var snackBar = const SnackBar(
                            content: Text(
                                'The account already exists for that email.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      print(e);
                    }
                    // try {
                    //   setState(() {
                    //     showSpinner = true;
                    //   });
                    //   UserCredential NewUser =
                    //       await _auth.createUserWithEmailAndPassword(
                    //           email: email!, password: password!);
                    //   Navigator.pushNamed(context, '/homepage');
                    // } catch (e) {
                    //   print(e);
                    // }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
