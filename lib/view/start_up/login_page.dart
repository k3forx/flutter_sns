import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/utils/authentication.dart';
import 'package:flutter_sns/view/screen.dart';
import 'package:flutter_sns/view/start_up/create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Coffee Memo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "メールアドレス",
                  ),
                )),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: passController,
              decoration: const InputDecoration(hintText: "パスワード"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(text: 'アカウントは作成していない方は'),
                TextSpan(
                  text: 'こちら',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountPage(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
              onPressed: () async {
                var isLoggedIn = await authentication.emailSignIn(
                    email: emailController.text, password: passController.text);
                if (isLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Screen(),
                    ),
                  );
                }
              },
              child: const Text('ログイン'))
        ]),
      )),
    );
  }
}
