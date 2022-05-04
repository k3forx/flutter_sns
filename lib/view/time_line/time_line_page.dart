import 'package:flutter/material.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';

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
        title: const Text('Coffee Memo',
            style: TextStyle(
              color: Colors.black,
            )),
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
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
              final CoffeeBean coffeeBean = snapShot.data![index];
              return GestureDetector(
                onTap: () => {print(coffeeBean.id)},
                child: SizedBox(
                  height: 50,
                  child: Center(child: Text('Entry ${coffeeBean.name}')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
