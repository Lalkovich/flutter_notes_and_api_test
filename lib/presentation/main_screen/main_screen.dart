import 'package:flutter/material.dart';
import 'package:flutter_notes_and_api_test/presentation/weather_screen/weather_screen.dart';

import '../list_notes_screen/list_notes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const ListNotesScreen(), WeatherScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thunderstorm_outlined),
            label: 'Weather',
          ),
        ],
      ),
    );
  }
}
