import 'package:flutter/material.dart';
import 'package:three_minute_diary/model/diart.dart';
import 'package:three_minute_diary/view/widget/custom_detailed_diary.dart';

class DiaryDetailedPage extends StatelessWidget {
  final Diary entry; // Diary 타입의 entry 변수 추가
  const DiaryDetailedPage({Key? key, required this.entry})
      : super(key: key); // 생성자에 entry 추가

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomDetailedDiary(entry), // entry 객체를 CustomDetailedDiary에 전달
          ],
        ),
      ),
    );
  }
}
