import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/utils/authentication.dart';
import 'package:flutter_sns/utils/firestore/users.dart';
import 'package:flutter_sns/utils/widget_utils.dart';
import 'package:flutter_sns/view/screen.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({Key? key, required this.email, required this.pass})
      : super(key: key);

  final String email;
  final String pass;

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('メールアドレスを確認'),
      body: Column(children: [
        const Text('届いたメールのリンクをクリックしてください。'),
        ElevatedButton(
            onPressed: () async {
              var result = await Authentication.emailSignIn(
                  email: widget.email, password: widget.pass);
              if (result is UserCredential) {
                if (result.user!.emailVerified) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  await UserFirestore.getUser(result.user!.uid);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Screen()));
                } else {
                  print("email verification is not finished");
                }
              }
            },
            child: const Text("認証完了"))
      ]),
    );
  }
}
