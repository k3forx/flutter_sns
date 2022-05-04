import 'package:flutter/material.dart';
import 'package:flutter_sns/utils/firestore/posts.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String? selectedRoastDegree = 'light';
  DateTime? _selectedDate;
  TextEditingController roastedAtController = TextEditingController();

  PostFirestore postFirestore = PostFirestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('コーヒー豆を登録する',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: '名前'),
            ),
            TextField(
              controller: farmNameController,
              decoration: const InputDecoration(hintText: '農園名'),
            ),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(hintText: '国'),
            ),
            DropdownButton<String>(
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
              onChanged: (String? value) {
                setState(() {
                  selectedRoastDegree = value;
                });
              },
              value: selectedRoastDegree,
            ),
            TextField(
              controller: roastedAtController,
              decoration: const InputDecoration(hintText: 'ロースト日'),
              onTap: () async {
                final newSelectedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate = DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2040),
                );

                if (newSelectedDate != null) {
                  _selectedDate = newSelectedDate;
                  roastedAtController.text =
                      DateFormat("yyyy-MM-dd").format(_selectedDate!);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty) {
                    var result = await postFirestore.addPost(
                      nameController.text,
                      farmNameController.text,
                      countryController.text,
                      selectedRoastDegree!,
                      roastedAtController.text,
                    );
                    if (result) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('登録'))
          ],
        ),
      ),
    );
  }
}
