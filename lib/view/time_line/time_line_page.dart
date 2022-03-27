import 'package:flutter/material.dart';
import 'package:flutter_sns/model/account.dart';
import 'package:flutter_sns/model/post.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'test user name',
    selfIntroduction: 'hello world',
    userId: 'test user id',
    imagePath:
        'https://cdn.icon-icons.com/icons2/2620/PNG/512/among_us_player_red_icon_156942.png',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
  );

  List<Post> postList = [
    Post(
      id: '1',
      content: 'hello too',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content: 'hello too 2',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '3',
      content: 'hello too 3',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイムライン',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    foregroundImage: NetworkImage(myAccount.imagePath),
                  ),
                  Expanded(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(myAccount.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('@${myAccount.userId}',
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            Text(DateFormat('M/d/yy')
                                .format(postList[index].createdTime!))
                          ],
                        ),
                        Text(postList[index].content),
                      ],
                    )),
                  )
                ],
              ),
            );
          }),
    );
  }
}
