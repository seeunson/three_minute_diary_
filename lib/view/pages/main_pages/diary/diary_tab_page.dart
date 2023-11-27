import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/view/pages/main_pages/diary/diary_detailed_page.dart';
import 'package:three_minute_diary/view/pages/main_pages/diary/diary_upload_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:three_minute_diary/view/widget/custom_detailed_diary.dart';

class DiaryTab extends GetView<DiaryController> {
  const DiaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(() => TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: controller.focusedDay.value,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay.value, day);
                },
                calendarBuilders: CalendarBuilders(
                  // 특정 날짜에 대한 커스텀 빌더
                  markerBuilder: (context, date, events) {
                    if (controller.isDiaryWrittenOn(date)) {
                      // 일기가 작성된 날짜에 대한 표시
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // 여기에 원하는 색상 설정
                        ),
                        width: 7,
                        height: 7,
                      );
                    }
                    return null; // 일기가 없는 날짜에는 아무것도 표시하지 않음
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay.isBefore(DateTime.now())) {
                    // 미래 날짜 선택 제한
                    controller.selectedDay.value = selectedDay;
                    controller.focusedDay.value = focusedDay;
                    controller.fetchDiaryEntries(); // 선택된 날짜에 해당하는 데이터 불러오기
                  }
                },
              )),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.diaryEntries.length,
                  itemBuilder: (context, index) {
                    final entry = controller.diaryEntries[index];
                    return GestureDetector(
                      onTap: () {
                        // 일기 상세 페이지로 이동
                        Get.to(DiaryDetailedPage(
                          entry: entry,
                        ));
                      },
                      child: ListTile(
                        title: Text(entry.title), // 일기 제목
                        trailing: Column(
                          children: [
                            Text(entry.mood), // 기분 또는 감정
                          ],
                        ),
                        // 여기에 필요한 경우 추가 ListTile 속성 추가
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(DiaryUploadPage()); // 일기 작성 페이지로 이동
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
