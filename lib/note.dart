import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({Key? key, required this.title, required this.body})
      : super(key: key);
  final String body;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTEX'),
      ),
      body: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
