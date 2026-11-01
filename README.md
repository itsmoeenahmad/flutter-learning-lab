# Flutter Learning Lab

Practical Flutter examples for the **CS-314 Mobile App Development Lab**. Run the app and open any week from the home screen.

## Run the project

```bash
flutter pub get
flutter run
```

## Weekly examples

| Week | Folder | Focus |
| --- | --- | --- |
| 04 | `lib/week_04` | Counter app, state, and reset button |
| 05 | `lib/week_05` | Basic widgets, layout, cards, and reusable UI |
| 06 | `lib/week_06` | Lists, grids, forms, validation, dialogs, and navigation |
| 07 | `lib/week_07` | Packages and secure storage on the device |
| 08 | `lib/week_08` | `setState`, `ChangeNotifier`, and Provider basics |
| 09 | `lib/week_09` | REST API requests, JSON models, and loading/error states |
| 10 | `lib/week_10` | Firebase setup guide and safe cloud-data demonstration |
| 11 | `lib/week_11` | Authentication UI and Firebase Auth/Firestore reference code |
| 12 | `lib/week_12` | Semester-project MVP: add and view a study task |
| 13 | `lib/week_13` | Validation, manual testing checklist, and a unit-test example |
| 14 | `lib/week_14` | Project polish and release-readiness checklist |
| 15 | `lib/week_15` | Final demonstration and viva-readiness checklist |

`lib/main.dart` is the learning hub. Each weekly folder keeps its example code separate and easy to review.

## Week 07 note

The project uses `flutter_secure_storage` to demonstrate protected on-device storage. Use it for sensitive values such as tokens or passwords; do not hard-code those values in your app.

## Weeks 08 and 09 packages

The runnable examples use these packages:

- `provider` for the small shared-counter demonstration in Week 08.
- `http` for the JSONPlaceholder API example in Week 09.

The Android manifest includes the Internet permission for API examples.

## Firebase notes for Weeks 10 and 11

Firebase packages are intentionally not added to this starter project yet. This keeps the project runnable before a Firebase project is configured.

When Firebase is configured during class, follow the commented examples in these files:

- `lib/week_10/firebase_setup_example.dart`
- `lib/week_11/firebase_auth_profile_example.dart`

Typical Firebase setup commands are:

```bash
flutter pub add firebase_core cloud_firestore firebase_auth
dart pub global activate flutterfire_cli
flutterfire configure
```

After `flutterfire configure` creates `lib/firebase_options.dart`, uncomment and adapt the Firebase code for the selected project. Do not place passwords, administrator keys, or other secrets in Flutter source code. Firebase Authentication and Firestore security rules must protect user-owned data.

## Weeks 12 to 15 project work

Weeks 12–15 are guided semester-project sessions. The included examples are small templates for one complete user flow, validation, manual testing, release checks, and final demonstration preparation. Teams should adapt them to their approved project instead of submitting the templates as a complete semester project.
