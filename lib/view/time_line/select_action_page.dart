import 'package:flutter/material.dart';
import 'package:flutter_sns/view/recipe/post_recipe_page.dart';
import 'package:flutter_sns/view/time_line/post_page.dart';

class SelectActionPage extends StatefulWidget {
  const SelectActionPage({Key? key}) : super(key: key);

  @override
  State<SelectActionPage> createState() => _SelectActionPageState();
}

class _SelectActionPageState extends State<SelectActionPage> {
  final List<String> menuTitles = <String>["コーヒー豆を登録する", "ドリップレシピを作成する"];
  final pageList = [const PostPage(), const PostRecipePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 80),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: menuTitles.length,
            itemBuilder: (BuildContext context, int index) {
              final String menuTitle = menuTitles[index];
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pageList[index],
                    ),
                  )
                },
                child: Container(
                  height: 50,
                  color: Colors.brown,
                  child: Center(
                    child: Text(
                      menuTitle,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
