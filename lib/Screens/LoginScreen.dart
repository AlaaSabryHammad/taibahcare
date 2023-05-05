import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String? logemail;
  String? logpassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          // text field size
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
                'Log in to your Account',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 191, 200),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  logemail = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  logpassword = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                  text: 'Log in',
                  press: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: logemail!, password: logpassword!);
                        Navigator.pushNamed(context, '/homepage');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/RegisterScreen');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 0, 191, 200),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
