import 'package:flutter/material.dart';
import 'package:flutter_sns/model/account.dart';
import 'package:flutter_sns/model/post.dart';
import 'package:flutter_sns/utils/authentication.dart';
import 'package:flutter_sns/utils/firestore/users.dart';
import 'package:flutter_sns/view/account/edit_account_page.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                foregroundImage:
                                    NetworkImage(myAccount.imagePath),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myAccount.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('@${myAccount.userId}',
                                      style:
                                          const TextStyle(color: Colors.grey))
                                ],
                              )
                            ],
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditAccountPage()));
                                if (result) {
                                  setState(() {
                                    myAccount = Authentication.myAccount!;
                                  });
                                }
                              },
                              child: const Text('編集'))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(myAccount.selfIntroduction),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.blue, width: 3))),
                  child: const Text('投稿',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: index == 0
                                  ? const Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 0,
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 0))
                                  : const Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 0))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                foregroundImage:
                                    NetworkImage(myAccount.imagePath),
                              ),
                              Expanded(
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(myAccount.name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('@${myAccount.userId}',
                                                style: const TextStyle(
                                                    color: Colors.green)),
                                          ],
                                        ),
                                        Text(DateFormat('M/d/yy').format(
                                            postList[index].createdTime!))
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
