import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.text, required this.press});
  final String text;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: const Color.fromARGB(255, 0, 191, 200),
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: press,
          minWidth: 250.0,
          height: 55.0,
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.press});
  final String text;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      // log in button
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: press,
          minWidth: 250.0,
          height: 55.0,
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color.fromARGB(255, 0, 191, 200)),
          ),
        ),
      ),
    );
  }
}

var ktextfield = InputDecoration(
  filled: true,
  fillColor: Colors.grey[51],
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal.shade200, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal.shade200, width: 2.0),
    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
  ),
);

class BoxStyle extends StatelessWidget {
  final IconData icon;
  final String text;
  final String page;
  const BoxStyle(
      {super.key, required this.text, required this.icon, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 160,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(130, 2, 168, 176),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 60, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, page);
      },
    );
  }
}

class BoxStyle2 extends StatelessWidget {
  var icon;
  var text;
  var page;
  BoxStyle2({super.key, this.text, this.icon, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 180,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(130, 2, 168, 176),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 70, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, page);
      },
    );
  }
}
