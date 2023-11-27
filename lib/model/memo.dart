import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  final String memo;
  final DateTime createdAt;

  Memo({required this.memo, required this.createdAt});

  factory Memo.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    DateTime createdAt = (data['createdAt'] as Timestamp).toDate();
    return Memo(
      memo: data['memo'] ?? '',
      createdAt: createdAt,
    );
  }

  // createdAt을 "yyyy-MM-dd HH:mm" 형식으로 변환하는 메소드
  String get formattedDateTime {
    return DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
  }
}
