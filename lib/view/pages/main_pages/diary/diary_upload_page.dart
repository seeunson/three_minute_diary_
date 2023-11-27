import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/controller/index/diary/diary_upload_controller.dart';

class DiaryUploadPage extends GetView<DiaryUploadController> {
  var diaryController = Get.find<DiaryController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimerDialog(); // 프레임이 그려진 후 다이얼로그 표시
    });
    return Scaffold(
      appBar: AppBar(title: Text("3분 일기")),
      body: ListView(
        shrinkWrap: true,
        children: [
          Obx(() {
            if (controller.remainingTime.value == 0) {
              // 타이머가 0초에 도달했을 때 다이얼로그 표시
              Future.delayed(Duration.zero, () => _showTimeUpDialog(context));
            }
            return Padding(
              padding: EdgeInsets.all(10),
              child: Text("남은 시간: ${controller.remainingTime}초"),
            );
          }),
          Row(
            children: [
              // 날짜 선택 버튼
              TextButton(
                onPressed: () => controller.pickDate(context),
                child: Obx(() => Text(
                    DateFormat.yMd().format(controller.selectedDate.value))),
              ),

              // 기분 선택 드롭다운
              Obx(() => DropdownButton(
                    value: controller.selectedMood.value,
                    items: controller.moods.map((String mood) {
                      return DropdownMenuItem(
                        value: mood,
                        child: Text(mood),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectedMood.value = newValue;
                      }
                    },
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: controller.titleFocusNode,
              controller: controller?.titleController ?? null,
              maxLines: 1, // 높이 조절
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "title",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: controller.contentFocusNode,
              controller: controller?.contentController ?? null,
              maxLines: 10, // 높이 조절
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "여기에 일기를 작성하세요.",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.upLoadText(); // 일기 저장
            },
            child: Text("저장하기"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startTimerDialog(),
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  // 시간 초과 다이얼로그
  void _showTimeUpDialog(BuildContext context) {
    if (!controller.isDialogShown) {
      controller.isDialogShown = true;
      // 다이얼로그 표시 로직...
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("시간 초과"),
            content: Text("3분이 끝났습니다. 일기는 자동으로 저장됩니다."),
            actions: <Widget>[
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  controller.upLoadText(); // 일기 저장
                  diaryController.fetchDiaryEntries();
                  Navigator.pop(context);
                  controller.resetTimer();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _startTimerDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("일기를 작성하시겠어요?"),
        content: Text("버튼을 누르시면 일기 작성이 시작됩니다."),
        actions: <Widget>[
          TextButton(
            child: Text("취소"),
            onPressed: () {
              Get.back(); // 다이얼로그 닫기
              Get.toNamed('/index');
            },
          ),
          TextButton(
            child: Text("확인"),
            onPressed: () {
              Get.back(); // 다이얼로그 닫기
              controller.startTimer(); // 타이머 시작
            },
          ),
        ],
      ),
      barrierDismissible: false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정
    );
  }
}
