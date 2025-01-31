import 'package:app_siswa/view/history_view.dart';
import 'package:app_siswa/view/home_view.dart';
import 'package:app_siswa/view/profile_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PPLG Apps",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final tabs = [
    const HomeView(),
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text(
          'PPLG Apps',
          style: TextStyle(color: Color.fromARGB(255, 162, 112, 249)),
        ),
        backgroundColor: const Color.fromARGB(255, 5, 1, 16),
      ),
      body: tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: currentindex,
        onTap: (index) {
          setState(() => currentindex = index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(Icons.home_max_rounded)),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
              activeIcon: Icon(Icons.history_edu)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              activeIcon: Icon(Icons.person_pin_circle_outlined))
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
