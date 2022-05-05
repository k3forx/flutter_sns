import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sns/model/account.dart';
import 'package:flutter_sns/utils/authentication.dart';
import 'package:flutter_sns/utils/function_utils.dart';
import 'package:flutter_sns/utils/widget_utils.dart';
import 'package:flutter_sns/view/start_up/login_page.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  Account myAccount = Authentication.myAccount!;

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();

  File? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('プロフィール編集'),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await FunctionUtils.getImageFromGallery();
                  if (result != null) {
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: '名前'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(hintText: 'ユーザーID'),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: const InputDecoration(hintText: '自己紹介'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {},
                child: const Text('更新'),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Authentication.signOut();
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text("ログアウト"),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  Authentication.deleteAuth();
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text("アカウント削除"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
