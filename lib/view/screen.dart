import 'package:flutter/material.dart';
import 'package:flutter_sns/view/account/account_page.dart';
import 'package:flutter_sns/view/recipe/recipe_page.dart';
import 'package:flutter_sns/view/time_line/select_action_page.dart';
import 'package:flutter_sns/view/time_line/time_line_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> pageList = [
    const TimeLinePage(),
    const RecipePage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(
            () {
              selectedIndex = index;
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectActionPage(),
            ),
          ).then(
            (_) => setState(
              () {
                selectedIndex = 0;
              },
            ),
          );
        },
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
