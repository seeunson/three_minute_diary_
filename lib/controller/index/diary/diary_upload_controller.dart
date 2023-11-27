import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/model/diart.dart';
import 'package:three_minute_diary/view/pages/main_pages/diary/diary_tab_page.dart';

class DiaryUploadController extends GetxController {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var remainingTime = 180.obs; // 반응형 변수로 남은 시간을 관리
  var isDialogShown = false; // 다이얼로그가 표시되었는지 추적
  var selectedDate = DateTime.now().obs;
  var selectedMood = 'Happy'.obs; // 예시 기본값
  final List<String> moods = ['Happy', 'Sad', 'Neutral'];
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode contentFocusNode = FocusNode();

  Timer? timer;

  void startTimer() {
    titleFocusNode.requestFocus(); // 타이머 시작 시 타이틀 필드에 포커스

    if (timer != null && timer!.isActive) {
      timer!.cancel(); // 기존 타이머가 활성화되어 있다면 취소합니다.
    }
    remainingTime.value = 180; // 타이머 시간을 5초로 재설정합니다.
    isDialogShown = false; // 다이얼로그 표시 플래그를 초기화합니다.

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        timer?.cancel();
        if (!isDialogShown) {
          // 여기에 다이얼로그를 표시하는 로직을 추가할 수 있습니다.
          isDialogShown = true;
        }
      }
    });
  }

  void resetTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel(); // 기존 타이머가 활성화되어 있다면 취소합니다.
    }
    remainingTime.value = 5; // remainingTime을 초기값으로 재설정합니다.
    isDialogShown = false; // 다이얼로그 표시 플래그를 초기화합니다.
  }

  void upLoadText() async {
    print(contentController.text);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // 사용자별 'diaries' 컬렉션에 데이터 저장
        await instance
            .collection('User')
            .doc(user.uid)
            .collection('diary')
            .add({
          'title': titleController.text,
          'content': contentController.text,
          'mood': selectedMood.value,
          'createdAt': selectedDate.value,
        });
        Get.back(); // 업로드 후 화면 이동 또는 닫기
      } on FirebaseException catch (e) {
        print('업로드 오류: $e');
      }
    } else {
      print('사용자가 로그인하지 않음');
    }
  }

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration.zero, () {
      timerStart();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  void timerStart() {
    Get.dialog(
      AlertDialog(
        title: Text('타이머'),
        content: Text('누르면 타이머가 시작됩니다.'),
        actions: [
          TextButton(
            onPressed: () {
              startTimer(); // 타이머 시작
              Get.back(); // 다이얼로그 닫기
            },
            child: Text('시작'),
          ),
        ],
      ),
    );
  }

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
