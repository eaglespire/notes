import 'dart:async';

import 'package:firebase_firestore/home.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MyHomePage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      color: Colors.grey.shade800,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOTES',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.orange),
            ),
            const CircularProgressIndicator(
              backgroundColor: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
