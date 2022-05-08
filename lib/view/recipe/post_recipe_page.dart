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
  final CoffeeBean coffeeBean = CoffeeBean(
    id: 1,
    name: "イルガチャフィ",
    roastDegree: "ライトロースト",
    roastedAt: DateTime.now(),
  );

  double sweetnessRating = 0;
  TextEditingController sweetnessMemoController = TextEditingController();
  double acidityRating = 0;
  TextEditingController memoController = TextEditingController();

  final List<int> ticks = [1, 2, 3, 4, 5];
  List<String> features = ["甘味", "酸味", "CC", "DD", "EE"];

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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                          Row(
                            children: const [
                              Text(
                                "テイスティング",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text("甘味"),
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
                                          itemSize: 20,
                                          onRatingUpdate: (rating) {
                                            sweetnessRating = rating;
                                            setState(() => {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("酸味"),
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
                                          itemSize: 20,
                                          onRatingUpdate: (rating) {
                                            acidityRating = rating;
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                                            sweetnessRating,
                                            acidityRating,
                                            1,
                                            2,
                                            3
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "ドリップレシピ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text("1. 20mlで20秒むらす"),
                  ],
                ),
              ),
              Padding(
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
    );
  }
}
