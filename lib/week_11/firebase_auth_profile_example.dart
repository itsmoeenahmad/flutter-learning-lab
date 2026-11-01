/*
  Week 11 Firebase Authentication and Firestore example

  Complete Week 10 Firebase configuration first, then run:

    flutter pub add firebase_auth cloud_firestore
    flutterfire configure

  In the Firebase console, enable Authentication > Sign-in method > Email/Password.

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class FirebaseAuthService {
    final _auth = FirebaseAuth.instance;

    User? get currentUser => _auth.currentUser;

    Future<void> register(String email, String password) async {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }

    Future<void> signIn(String email, String password) async {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }

    Future<void> signOut() async => _auth.signOut();
  }

  class ProfileService {
    final _users = FirebaseFirestore.instance.collection('users');

    Future<void> saveProfile({
      required String uid,
      required String displayName,
      required String department,
    }) async {
      await _users.doc(uid).set({
        'displayName': displayName,
        'department': department,
      }, SetOptions(merge: true));
    }

    Future<Map<String, dynamic>?> loadProfile(String uid) async {
      return (await _users.doc(uid).get()).data();
    }
  }

  Start with rules that allow a signed-in user to read and write only their
  own profile document. Apply and test rules in the Firebase console:

  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /users/{userId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }

  Never log passwords, store passwords in Firestore, or place administrator
  credentials in Flutter code.
*/
