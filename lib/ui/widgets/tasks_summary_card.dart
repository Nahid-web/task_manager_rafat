import 'package:flutter/material.dart';

class TasksSummaryCard extends StatelessWidget {
  const TasksSummaryCard({
    super.key,
    required this.count,
    required this.tittle
  });
  final String count, tittle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            Text(count, style: Theme.of(context).textTheme.titleLarge,),
            Text(tittle),
          ],
        ),
      ),
    );
  }
}
