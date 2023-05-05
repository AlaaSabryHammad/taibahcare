import 'package:flutter/material.dart';
import 'package:taibahcare/Screens/Additional.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? age;
  String? social;
  String? firstname;
  String? lastname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 140.0,
                    child: Image.asset('images/taibah.png'),
                  ),
                ),
              ),
              const Text(
                'Create New Account',
                style: TextStyle(
                  fontSize: 23.0,
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
                  firstname = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your first name',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  lastname = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your last name',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  age = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Enter your age',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  social = value;
                },
                decoration: ktextfield.copyWith(
                  hintText: 'Social Status',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                  text: 'Continue',
                  press: () {
                    if (firstname == null ||
                        lastname == null ||
                        age == null ||
                        social == null) {
                      var snackBar = const SnackBar(
                          content: Text('Complete all fields ..'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Additional(
                                  fName: firstname!,
                                  lName: lastname!,
                                  age: age!,
                                  status: social!)));
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/LoginScreen');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 0, 191, 200),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
