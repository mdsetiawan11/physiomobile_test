import 'package:flutter/material.dart';
import 'package:physiomobile_test/core/utils/constant.dart';
import 'package:physiomobile_test/pages/counter_page.dart';
import 'package:physiomobile_test/pages/form_page.dart';
import 'package:physiomobile_test/pages/post_page.dart';
import 'package:provider/provider.dart';

import '../core/providers/navigation_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Widget> _pages = [PostPage(), FormPage(), CounterPage()];

  static final List<String> _titles = ['Posts', 'Form', 'Counter'];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final currentIndex = navigationProvider.currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[currentIndex]),
        centerTitle: true,
        backgroundColor: appColor,
        foregroundColor: Colors.white,
      ),
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: navigationProvider.setIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: appColor,
            unselectedItemColor: Colors.grey[400],
            showSelectedLabels: true,
            showUnselectedLabels: false,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                activeIcon: Icon(Icons.article),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                activeIcon: Icon(Icons.assignment),
                label: 'Form',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Counter',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
