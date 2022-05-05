import 'package:flutter/material.dart';
import 'package:flutter_sns/view/account/account_page.dart';
import 'package:flutter_sns/view/time_line/post_page.dart';
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
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: ''),
          // BottomNavigationBarItem(icon: Icon(Icons.store_sharp), label: ''),
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
              builder: (context) => const PostPage(),
            ),
          ).then(
            (_) => setState(() {
              selectedIndex = 0;
            }),
          );
        },
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
