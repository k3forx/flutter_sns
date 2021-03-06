import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:flutter_sns/view/recipe/post_recipe_page.dart';
import 'package:flutter_sns/view/start_up/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coffee Memo App",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // home: const LoginPage(),
      home: const PostRecipePage(),
    );
  }
}
