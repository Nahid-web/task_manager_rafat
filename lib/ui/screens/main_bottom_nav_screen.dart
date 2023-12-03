import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/canceled_tasks_screen.dart';
import 'package:task_manager_rafat/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager_rafat/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_rafat/ui/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTasksScreen(),
    CompletedTasksScreen(),
    CanceledTasksScreen(),
    ProgressTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Canceled'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Progress'),
        ],
      ),
    );
  }
}
