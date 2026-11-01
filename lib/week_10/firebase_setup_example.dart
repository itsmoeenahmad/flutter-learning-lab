/*
  Week 10 Firebase setup example

  Keep this code commented until Firebase is configured for this project.
  This lets students run the classroom project without Firebase errors.

  1. Create a Firebase project in the Firebase console.
  2. From the Flutter project folder, run:

     flutter pub add firebase_core cloud_firestore
     dart pub global activate flutterfire_cli
     flutterfire configure

  3. The FlutterFire CLI creates lib/firebase_options.dart.
  4. Replace main() with the following code:

  import 'package:firebase_core/firebase_core.dart';
  import 'firebase_options.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const FlutterLearningApp());
  }

  5. A simple Firestore service can read demo-only course topics:

  import 'package:cloud_firestore/cloud_firestore.dart';

  class FirebaseTopicService {
    final _topics = FirebaseFirestore.instance.collection('topics');

    Future<List<String>> loadTopics() async {
      final snapshot = await _topics.get();
      return snapshot.docs
          .map((document) => document.data()['title'] as String)
          .toList();
    }
  }

  Use only safe sample records in Week 10. Do not add private student data or
  open public write access just for a classroom demonstration.
*/
