import 'package:flutter/material.dart';

import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:intl/intl.dart';

class PostRecipePage extends StatefulWidget {
  const PostRecipePage({Key? key}) : super(key: key);

  @override
  State<PostRecipePage> createState() => _PostRecipePageState();
}

class _PostRecipePageState extends State<PostRecipePage> {
  final int headFontSize = 18;
  final CoffeeBean coffeeBean = CoffeeBean(
    id: 1,
    name: "イルガチャフィ",
    roastDegree: "ライトロースト",
    roastedAt: DateTime.now(),
  );

  double flavorRating = 0;
  double sweetnessRating = 0;
  double acidityRating = 0;
  double bodyRating = 0;
  double balanceRating = 0;

  final List<int> ticks = [1, 2, 3, 4, 5];
  List<String> features = ["香り", "甘味", "酸味", "ボディ", "バランス"];

  TextEditingController coffeeBeanWeightController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ドリップレシピを登録する",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  height: 110,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "コーヒー豆",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text(
                                  coffeeBean.name,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "農園: ${coffeeBean.farmName}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "焙煎度: ${coffeeBean.roastDegree}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Expanded(
                                      child: SizedBox(
                                        width: 20,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "原産国: ${coffeeBean.country}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "焙煎日: ${DateFormat("yyyy-MM-dd").format(coffeeBean.roastedAt!)}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "テイスティング",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 60,
                                            child: Text("香り"),
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 18,
                                            onRatingUpdate: (rating) {
                                              flavorRating = rating;
                                              setState(() => {});
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            child: Text("甘味"),
                                            width: 60,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 18,
                                            onRatingUpdate: (rating) {
                                              sweetnessRating = rating;
                                              setState(() => {});
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            child: Text("酸味"),
                                            width: 60,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 18,
                                            onRatingUpdate: (rating) {
                                              acidityRating = rating;
                                              setState(() => {});
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            child: Text("ボディ"),
                                            width: 60,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 18,
                                            onRatingUpdate: (rating) {
                                              bodyRating = rating;
                                              setState(() => {});
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            child: Text("バランス"),
                                            width: 60,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 18,
                                            onRatingUpdate: (rating) {
                                              balanceRating = rating;
                                              setState(() => {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: RadarChart(
                                          featuresTextStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                          ticksTextStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 0,
                                          ),
                                          outlineColor: Colors.grey,
                                          ticks: ticks,
                                          features: features,
                                          data: [
                                            [
                                              flavorRating,
                                              sweetnessRating,
                                              acidityRating,
                                              bodyRating,
                                              balanceRating,
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "ドリップレシピ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("豆の量 (g)"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: coffeeBeanWeightController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("挽き目"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: coffeeBeanWeightController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: [
                                const Text("水量"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: [
                                const Text("水温"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text("1. 20mlで20秒むらす"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "メモ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                        controller: memoController,
                        decoration:
                            const InputDecoration(hintText: "xx文字まで入力できます"),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("登録"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
