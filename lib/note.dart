import 'package:flutter/material.dart';

dynamic note;

class Note extends StatefulWidget {
  Note(dynamic items) {
    note = items;
  }

  @override
  State createState() {
    return MyNote();
  }
}

class MyNote extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("笔记"),
          backgroundColor: const Color.fromARGB(255, 153, 204, 102),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: Column(children: <Widget>[
              Align(
                alignment: FractionalOffset.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0,top: 15.0),
                  child: Text(
                    note['name'],
                    style: const TextStyle(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                      fontSize: 23.0,
                      color: Color.fromARGB(255, 70, 90, 70),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    note['discribe'],
                    style: const TextStyle(
                      letterSpacing: 4.0,
                      fontSize: 17.0,
                      height: 1.8,
                      color: Color.fromARGB(255, 70, 90, 70),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
