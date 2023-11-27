import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:three_minute_diary/model/diart.dart';
import 'package:three_minute_diary/model/memo.dart';

class MemoTabController extends GetxController {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  var memoEntries = <Memo>[].obs; // DiaryEntry는 사용자 정의 클래스
  var memoController = TextEditingController();
  var currentDate = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMemoEntries(); // Firestore에서 데이터 가져오기
  }

  // 날짜를 증가시키는 메소드
  void incrementDate() {
    currentDate.value = currentDate.value.add(Duration(days: 1));
    fetchMemoEntries();
  }

  // 날짜를 감소시키는 메소드
  void decrementDate() {
    currentDate.value = currentDate.value.subtract(Duration(days: 1));
    fetchMemoEntries();
  }

  void addMemo(String memoText) {
    var newMemo = Memo(memo: memoText, createdAt: DateTime.now());
    memoEntries.insert(0, newMemo); // 메모 목록의 시작 부분에 새 메모 추가
  }

  UploadMemo() async {
    print(memoController.text);
    try {
      await instance.collection('memo').add({
        'memo': memoController.text,
      });
      Get.back();
    } on FirebaseException catch (e) {
      print('업로드 오류: $e');
    }
  }

  void fetchMemoEntries() async {
    var fetchedMemoEntries = await fetchMemoEntriesFromFirestore();
    this.memoEntries.assignAll(fetchedMemoEntries); // 멤버 변수를 명시적으로 참조
    print(fetchedMemoEntries);
  }

  Future<List<Memo>> fetchMemoEntriesFromFirestore() async {
    var memoSnapshot =
        await FirebaseFirestore.instance.collection('memo').get();

    print(memoSnapshot.docs[3].data());
    return memoSnapshot.docs.map((doc) => Memo.fromFirestore(doc)).toList();
  }

  @override
  void onClose() {
    memoController.dispose();
    super.onClose();
  }
}
