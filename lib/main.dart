import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const NotePage(),
    );
  }
}

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fire Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _createBody(),
      ),
    );
  }

  Widget _createBody() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('notes')
          .doc('quick')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot<Map<String, dynamic>>? doc = snapshot.data;

          if (doc != null && doc.exists) {
            return Text(doc['content']);
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
