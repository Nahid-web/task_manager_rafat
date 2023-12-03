import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/profile_summary_tile.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ProfileSummaryTile(),
          Expanded(
            child: BodyBackground(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Subject'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(hintText: 'Description'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewTasksScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.arrow_circle_right_outlined))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
