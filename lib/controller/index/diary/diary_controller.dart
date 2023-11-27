import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:three_minute_diary/model/diart.dart';

class DiaryController extends GetxController {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  var diaryEntries = <Diary>[].obs;
  var textController = TextEditingController();

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiaryEntries(); // Firestore에서 데이터 가져오기

    ever(selectedDay, (_) {
      focusedDay.value = selectedDay.value;
      fetchDiaryEntries(); // 선택된 날짜가 변경될 때마다 데이터 갱신
    });
  }

  bool isDiaryWrittenOn(DateTime date) {
    return diaryEntries.any((diary) {
      return isSameDay(diary.createdAt, date); // isSameDay는 날짜가 같은지 확인하는 함수
    });
  }

  void fetchDiaryEntries() async {
    diaryEntries.clear(); // 기존 데이터 초기화
    var entries = await fetchDiaryEntriesFromFirestore(selectedDay.value);
    diaryEntries.assignAll(entries);
  }

  Future<List<Diary>> fetchDiaryEntriesFromFirestore(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timestamp startOfDay = Timestamp.fromDate(
        DateTime(date.year, date.month, date.day, 0, 0, 0),
      );
      Timestamp endOfDay = Timestamp.fromDate(
        DateTime(date.year, date.month, date.day, 23, 59, 59),
      );

      var diarySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .collection('diary')
          .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
          .where('createdAt', isLessThanOrEqualTo: endOfDay)
          .get();

      return diarySnapshot.docs.map((doc) => Diary.fromFirestore(doc)).toList();
    } else {
      return [];
    }
  }
}
