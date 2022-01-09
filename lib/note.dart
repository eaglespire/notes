import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note(
      {Key? key,
      required this.title,
      required this.body,
      required this.date,
      required this.category})
      : super(key: key);
  final String body;
  final String title;
  final String date;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTEX'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: Text(
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.grey),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: Text(
                  body,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 20.0,
                      fontFamily: 'Helvetica-R',
                      height: 1.5),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: Text(
                  'Category - $category',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
