import 'package:flutter/material.dart';
import 'package:taibahcare/Style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70),
            )),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            margin:
                                const EdgeInsets.only(top: 90.0, right: 10.0),
                            height: 300.0,
                            child: Image.asset('images/taibah.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.4,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 191, 200),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Log in',
                        press: () {
                          Navigator.pushNamed(context, '/LoginScreen');
                        },
                      ),
                      // Button(text: 'Register', press:() {
                      //   Navigator.pushNamed(context, '/RegisterScreen');
                      // },),
                      Button(
                          text: 'Admin',
                          press: () {
                            Navigator.pushNamed(context, '/AdminHome');
                          }),
                      Button(
                          text: 'Doctor',
                          press: () {
                            Navigator.pushNamed(context, '/DoctorHome');
                          })
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
