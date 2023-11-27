import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String title;
  final String content;
  final DateTime createdAt;
  final String mood;

  Diary(
      {required this.createdAt,
      required this.mood,
      required this.title,
      required this.content});

  // Firestore 문서에서 DiaryEntry 객체를 생성하는 팩토리 생성자
  factory Diary.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Diary(
      createdAt: (data['createAt'] as Timestamp?)?.toDate() ??
          DateTime.now(), // Timestamp를 DateTime으로 변환
      mood: data['mood'] ?? 'No mood',

      title: data['title'] ?? 'No Title',
      content: data['content'] ?? 'No Content',
    );
  }
}
