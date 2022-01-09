import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // text fields' controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notess');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _categoryController.text = documentSnapshot['category'];
      _titleController.text = documentSnapshot['title'];
      _bodyController.text = documentSnapshot['body'];
      //  _dateController.text = documentSnapshot['date'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _bodyController,
                  decoration: const InputDecoration(
                      labelText: 'Start typing'
                          '...'),
                ),
                // TextField(
                //   controller: _dateController,
                //   decoration: const InputDecoration(
                //       labelText: 'Date'
                //           '...'),
                // ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? title = _titleController.text;
                    final String? category = _categoryController.text;
                    final String? body = _bodyController.text;
                    // final String? date = _dateController.
                    if (category != null && body != null && title != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _notes.add({
                          "category": category,
                          "body": body,
                          "title": title,
                          "date": getTodayDate()
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _notes.doc(documentSnapshot!.id).update({
                          "category": category,
                          "body": body,
                          "title": title,
                          "date": getTodayDate()
                        });
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _categoryController.text = '';
                      _bodyController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleting a note by id
  Future<void> _deleteNote(String noteId) async {
    await _notes.doc(noteId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note removed'),
      ),
    );
  }

  String getTodayDate() {
    var now = DateTime.now();
    var newDate = DateFormat.yMMMMd().format(now);
    return newDate;
  }

  // Used to generate random integers

  @override
  Widget build(BuildContext context) {
    final _random = Random();

    List<Color> colors = [
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.blue.shade800,
      Colors.green.shade900,
      Colors.deepOrange,
    ];
    // var now = DateTime.now();
    // var newDate = DateFormat.yMMMMd().format(now);
    // print(newDate.runtimeType);
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);
    // print(formattedDate); // 2016-01-25

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Container(
        padding: EdgeInsets.only(top: 15.0),
        child: StreamBuilder(
          stream: _notes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    // color:
                    //     Colors.primaries[_random.nextInt(Colors.primaries.length)]
                    //         [_random.nextInt(9) * 100],
                    color: colors[_random.nextInt(colors.length - 1)],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            documentSnapshot['category'],
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            documentSnapshot['title'],
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            documentSnapshot['date'].toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // // Press this button to edit a single note
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot),
                              ),
// // This icon button is used to delete a single note
                              IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _deleteNote(documentSnapshot.id)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
    );
  }
}

// return ListView.builder(
// itemCount: streamSnapshot.data!.docs.length,
// itemBuilder: (context, index) {
// final DocumentSnapshot documentSnapshot =
// streamSnapshot.data!.docs[index];
// return Card(
// margin: const EdgeInsets.all(10),
// child: ListTile(
// title: Text(documentSnapshot['name']),
// subtitle: Text(documentSnapshot['age'].toString()),
// trailing: SizedBox(
// width: 100,
// child: Row(
// children: [
// // Press this button to edit a single product
// IconButton(
// icon: const Icon(Icons.edit),
// onPressed: () => _createOrUpdate(documentSnapshot),
// ),
// // This icon button is used to delete a single product
// IconButton(
// icon: const Icon(Icons.delete),
// onPressed: () =>
// _deleteUser(documentSnapshot.id)),
// ],
// ),
// ),
// ),
// );
// },
// );
