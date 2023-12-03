import 'package:flutter/material.dart';

import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryTile(),
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
