import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/add_new_task_screen.dart';

import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';
import '../widgets/tasks_summary_card.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen(),));

        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryTile(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    TasksSummaryCard(count: '09', tittle: 'Canceled'),
                    TasksSummaryCard(count: '09', tittle: 'Completed'),
                    TasksSummaryCard(count: '09', tittle: 'Progress'),
                    TasksSummaryCard(count: '09', tittle: 'New Task'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskItemCard();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
