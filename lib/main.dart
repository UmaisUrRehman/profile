import 'package:flutter/material.dart';
import 'screens/form_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const FoundationsApp());
}

class FoundationsApp extends StatelessWidget {
  const FoundationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Foundations & UI Mastery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
          surface: Colors.white,
        ),
      ),
      home: const MainNavigationHome(),
    );
  }
}

class MainNavigationHome extends StatefulWidget {
  const MainNavigationHome({super.key});

  @override
  State<MainNavigationHome> createState() => _MainNavigationHomeState();
}

class _MainNavigationHomeState extends State<MainNavigationHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    UserRegistrationFormScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Form & Input',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile UI',
          ),
        ],
      ),
    );
  }
}
