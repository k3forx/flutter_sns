import 'package:flutter/widgets.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';

class CoffeeBeanDetailPage extends StatefulWidget {
  const CoffeeBeanDetailPage({Key? key}) : super(key: key);

  @override
  _CoffeeBeanDetailPage createState() => _CoffeeBeanDetailPage();
}

class _CoffeeBeanDetailPage extends State<CoffeeBeanDetailPage> {
  PostFirestore postFirestore = PostFirestore();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
