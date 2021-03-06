import 'package:flutter/material.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:flutter_sns/model/result.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';
import 'package:intl/intl.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

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
  String selectedRoastDegree = "";

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
            TextEditingController countryController =
                TextEditingController(text: coffeeBean.country);
            TextEditingController roastedAtController = TextEditingController(
                text: DateFormat("yyyy-MM-dd").format(coffeeBean.roastedAt!));

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
                            SizedBox(
                              height: 30,
                            ),
                            Text("原産国"),
                            SizedBox(
                              height: 30,
                            ),
                            Text("焙煎度"),
                            SizedBox(
                              height: 30,
                            ),
                            Text("焙煎日"),
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
                          TextField(
                            controller: countryController,
                          ),
                          DropdownButtonFormField<String>(
                            items: const [
                              DropdownMenuItem(
                                child: Text('ライトロースト'),
                                value: 'light',
                              ),
                              DropdownMenuItem(
                                child: Text('シナモンロースト'),
                                value: 'chinamon',
                              ),
                              DropdownMenuItem(
                                child: Text('ミディアムロースト'),
                                value: 'medium',
                              ),
                              DropdownMenuItem(
                                child: Text('ハイロースト'),
                                value: 'high',
                              ),
                              DropdownMenuItem(
                                child: Text('シティロースト'),
                                value: 'city',
                              ),
                              DropdownMenuItem(
                                child: Text('フルシティロースト'),
                                value: 'fullcity',
                              ),
                              DropdownMenuItem(
                                child: Text('フレンチロースト'),
                                value: 'french',
                              ),
                              DropdownMenuItem(
                                child: Text('イタリアンロースト'),
                                value: 'italian',
                              ),
                            ],
                            onSaved: (String? value) {
                              coffeeBean.roastDegree = value!;
                            },
                            onChanged: (String? value) {
                              selectedRoastDegree = value!;
                            },
                            value: coffeeBean.roastDegree,
                          ),
                          TextField(
                            controller: roastedAtController,
                            onTap: () async {
                              final newSelectedDate = await showDatePicker(
                                context: context,
                                initialDate: coffeeBean.roastedAt!,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2040),
                                cancelText: "戻る",
                              );
                              if (newSelectedDate != null) {
                                roastedAtController.text =
                                    DateFormat("yyyy-MM-dd")
                                        .format(newSelectedDate);
                              }
                            },
                          )
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
                        onPressed: () async {
                          coffeeBean.name = nameController.text;
                          coffeeBean.farmName = farmNameController.text;
                          coffeeBean.country = countryController.text;
                          if (selectedRoastDegree != "") {
                            coffeeBean.roastDegree = selectedRoastDegree;
                          }
                          var result = await postFirestore.update(coffeeBean);
                          if (result.isSuccess()) {
                            Navigator.pop(context);
                          } else {
                            showAlert(context, result);
                          }
                        },
                        child: const Text('編集する'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Background color
                        ),
                        child: const Text("削除する"),
                        onPressed: () async {
                          if (await confirm(
                            context,
                            title: const Text(""),
                            content: const Text("削除しますか？"),
                            textCancel: const Text("キャンセル"),
                          )) {
                            final result =
                                await postFirestore.delete(coffeeBeanId);
                            if (result.isSuccess()) {
                              Navigator.pop(context);
                            } else {
                              showAlert(context, result);
                            }
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void showAlert(BuildContext context, Result res) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          res.getDetailMessage(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
