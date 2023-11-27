import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:three_minute_diary/controller/index/memo/memo_tab_controller.dart'; // intl 패키지 임포트

class MemoTabPage extends GetView<MemoTabController> {
  const MemoTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            DateFormat('yyyy.MM.dd').format(controller.currentDate.value))),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              controller.decrementDate();
            },
          ),
        ),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                controller.incrementDate();
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.memoEntries.isEmpty) {
          // 데이터가 없는 경우 표시할 위젯
          return Center(child: Text('메모가 없습니다.'));
        }

        return ListView.builder(
          itemCount: controller.memoEntries.length,
          itemBuilder: (context, index) {
            final memoEntry = controller.memoEntries[index];
            return ListTile(
              subtitle: Text(memoEntry.memo),
            );
          },
        );
      }),
      bottomSheet: Container(
        color: Colors.blue,
        height: 100.0,
        alignment: Alignment.center,
        child: TextField(
          controller: controller.memoController,
          decoration: InputDecoration(
            hintText: '메모를 입력하세요',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                if (controller.memoController.text.isNotEmpty) {
                  controller.addMemo(controller.memoController.text);
                  controller.UploadMemo();
                  controller.memoController.clear();
                }
              },
            ),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              controller.addMemo(value);
              controller.UploadMemo();
              controller.memoController.clear();
            }
          },
        ),
      ),
    );
  }
}
