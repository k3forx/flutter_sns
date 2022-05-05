import 'package:flutter/material.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';
import 'package:flutter_sns/view/coffee_bean/detail.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  PostFirestore postFirestore = PostFirestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Coffee Memo',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
      ),
      body: FutureBuilder<List<CoffeeBean>>(
        future: postFirestore.getAll(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
              final CoffeeBean coffeeBean = snapShot.data![index];
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoffeeBeanDetailPage(
                        coffeeBeanId: coffeeBean.id,
                      ),
                    ),
                  ).then(
                    (_) => setState(() {}),
                  ),
                },
                child: Card(
                  child: ListTile(
                    title: Text(coffeeBean.name),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("農園: ${coffeeBean.farmName}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("焙煎度: ${coffeeBean.roastDegree}"),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("原産国: ${coffeeBean.country}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "焙煎度: ${DateFormat("yyyy-MM-dd").format(coffeeBean.roastedAt!)}",
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
