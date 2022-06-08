
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'view/app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
  apiKey: "AIzaSyDoETl-DSAHirpVrAk5b2EEfl4jxZpb06c",
  projectId: "japas-food",
  messagingSenderId: "512380894229",
  appId: "1:512380894229:web:603c29208e8882fc38a21c",
  ),
  );
  runApp(App());
}