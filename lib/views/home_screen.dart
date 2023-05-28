import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/views/attendance_event_screen.dart';
import '/views/attendance_manager_screen.dart';
import 'package:get/get.dart';
import '/views/login/login_screen.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return const Text("Trang chủ");
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final List<Widget> _screens = [
    const _HomeScreen(),
    const AttendanceEventScreen(),
    const AttendanceManagerScreen()
  ];

  final destinations = [
    const NavigationDestination(
        icon: Icon(Icons.home_work_outlined), label: "Hoạt động"),
    const NavigationDestination(
        icon: Icon(Icons.work_history_outlined), label: "Điểm danh"),
    const NavigationDestination(
        icon: Icon(Icons.logout_outlined), label: "Thoát"),
  ];

  int _currentScreenIndex = 0;

  handleDestinationSelected(int index) async {
    if (index == destinations.length - 1) {
      final SharedPreferences prefs = await _prefs;
      prefs.remove("access_token");
      Get.off(const LoginScreen());
    } else {
      setState(() {
        _currentScreenIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: _currentScreenIndex,
        onDestinationSelected: handleDestinationSelected,
      ),
      body: _screens[_currentScreenIndex],
    );
  }
}
