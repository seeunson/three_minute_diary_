import 'package:flutter/material.dart';
import 'package:three_minute_diary/model/diart.dart';

class CustomDiaryListTile extends StatelessWidget {
  final Diary tileInfo;
  const CustomDiaryListTile(Diary entry, {super.key, required this.tileInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tileInfo.title), // 일기 제목
      trailing: Column(
        children: [
          Text(tileInfo.mood), // 기분 또는 감정
        ],
      ),
    );
  }
}
