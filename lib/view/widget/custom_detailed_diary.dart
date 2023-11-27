import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/model/diart.dart';

class CustomDetailedDiary extends StatelessWidget {
  final Diary diary;
  const CustomDetailedDiary(this.diary, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10), // 패딩 추가
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 내용을 왼쪽 정렬
          children: [
            Row(
              children: [
                Text(diary.createdAt.toString()), // 기분 또는 감정
                Spacer(),
                Text(diary.mood), // 기분 또는 감정
              ],
            ),

            Text(diary.title,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)), // 일기 제목
            SizedBox(height: 10), // 간격 추가
            Text(diary.content), // 일기 내용
            SizedBox(height: 10), // 간격 추가
            // 여기에 추가적인 정보 표시 가능
          ],
        ),
      ),
    );
  }
}
