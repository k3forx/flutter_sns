import 'package:flutter/material.dart';

import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sns/model/brewing_recipe_form.dart';
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
  TextEditingController grindController = TextEditingController();
  TextEditingController waterWeightController = TextEditingController();
  TextEditingController waterTemperatureController = TextEditingController();
  TextEditingController opsMemoController = TextEditingController();

  List<BrewingRecipeForm> brewingRecipeFormList = [];

  @override
  void dispose() {
    for (var element in brewingRecipeFormList) {
      element.dispose();
    }

    super.dispose();
  }

  void add() {
    setState(() {
      brewingRecipeFormList.add(BrewingRecipeForm.create(""));
    });
  }

  void remove(int id) {
    final removedItem =
        brewingRecipeFormList.firstWhere((element) => element.id == id);
    setState(
      () {
        brewingRecipeFormList.removeWhere((element) => element.id == id);
      },
    );

    // itemのcontrollerをすぐdisposeすると怒られるので
    // 少し時間をおいてからdipose()
    Future.delayed(const Duration(seconds: 1)).then((value) {
      removedItem.dispose();
    });
  }

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
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("豆の量 (g)"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: coffeeBeanWeightController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "0",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("挽き目"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: grindController,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "-",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("水量 (g)"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: waterWeightController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "0",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Column(
                              children: [
                                const SizedBox(
                                  child: Text("水温 (°C)"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: waterTemperatureController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "0",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 280,
                        width: 310,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const Text(
                              "手順",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            ...brewingRecipeFormList
                                .map((item) => textFieldItem(item)),
                            const SizedBox(
                              height: 15,
                            ),
                            brewingRecipeFormList.length < 5
                                ? SizedBox(
                                    height: 25,
                                    width: 10,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        add();
                                      },
                                      child: const Text("追加"),
                                      style: ElevatedButton.styleFrom(),
                                    ),
                                  )
                                : const SizedBox(height: 0),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "メモ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              child: TextField(
                                controller: memoController,
                                decoration: const InputDecoration(
                                  hintText: "xx文字まで入力できます",
                                ),
                                maxLines: null,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: SizedBox(
                                width: 100,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("登録"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldItem(
    BrewingRecipeForm brewingRecipeForm,
  ) {
    return Row(
      children: [
        SizedBox(
          height: 25,
          width: 250,
          child: TextField(
            controller: brewingRecipeForm.controller,
            onChanged: (text) {
              setState(
                () {
                  brewingRecipeFormList = brewingRecipeFormList
                      .map(
                        (e) => e.id == brewingRecipeForm.id
                            ? brewingRecipeForm.change(text)
                            : e,
                      )
                      .toList();
                },
              );
            },
            style: const TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 25,
          child: IconButton(
            iconSize: 25,
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              remove(brewingRecipeForm.id);
            },
          ),
        )
      ],
    );
  }
}
