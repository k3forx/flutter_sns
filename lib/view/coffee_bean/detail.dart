import 'package:flutter/material.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';

class CoffeeBeanDetailPage extends StatefulWidget {
  final int coffeeBeanId;
  const CoffeeBeanDetailPage({
    Key? key,
    this.coffeeBeanId = 0,
  }) : super(key: key);

  @override
  _CoffeeBeanDetailPage createState() => _CoffeeBeanDetailPage();
}

class _CoffeeBeanDetailPage extends State<CoffeeBeanDetailPage> {
  PostFirestore postFirestore = PostFirestore();

  @override
  Widget build(BuildContext context) {
    final coffeeBeanId = widget.coffeeBeanId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "コーヒー豆を編集する",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<CoffeeBean>(
          future: postFirestore.getById(coffeeBeanId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final CoffeeBean coffeeBean = snapshot.data!;
            TextEditingController nameController =
                TextEditingController(text: coffeeBean.name);
            TextEditingController farmNameController =
                TextEditingController(text: coffeeBean.farmName);

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: const [
                            Text("名前"),
                            SizedBox(
                              height: 30,
                            ),
                            Text('農園名'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                          ),
                          TextField(
                            controller: farmNameController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          coffeeBean.name = nameController.text,
                          coffeeBean.farmName = farmNameController.text,
                        },
                        child: const Text('編集する'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
