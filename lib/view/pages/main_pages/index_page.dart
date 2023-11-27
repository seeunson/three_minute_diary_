import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_minute_diary/view/pages/main_pages/memo/memo_tab_page.dart';
import 'package:three_minute_diary/view/pages/main_pages/tabs/profile_tab.dart';
import 'package:three_minute_diary/view/pages/main_pages/diary/diary_tab_page.dart';
import 'package:three_minute_diary/view/pages/main_pages/tabs/home_tab.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    MemoTabPage(),
    DiaryTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          automaticallyImplyLeading: false,
        ),
        body: _tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              label: 'Memo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
