import 'package:country_explorer_app/screen/home.dart';
import 'package:country_explorer_app/screen/saved_screen.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [Home(), SavedScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10.0,
          children: [
            Icon(color: Color(0xFF162E93), Icons.public, size: 28.0),
            Text(
              'Global Explorer',
              style: TextStyle(
                color: Color(0xFF162E93),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // IconButton.outlined(onPressed: () {}, icon: Icon(Icons.search)),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),

          //   child: IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Search()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },

        items: [
          BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.home)),
          // BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: 'Saved', icon: Icon(Icons.bookmark)),
        ],
      ),
    );
  }
}
