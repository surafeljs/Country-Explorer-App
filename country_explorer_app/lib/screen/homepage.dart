import 'package:country_explorer_app/screen/home.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10.0,
          children: [
            Icon(Icons.public, size: 28.0),
            Text(
              'Global Explorer',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // IconButton.outlined(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {},
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),

      body: Home(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,

        items: [
          BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
        ],
      ),
    );
  }
}
