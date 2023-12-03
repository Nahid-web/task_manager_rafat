import 'package:flutter/material.dart';


class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task tittle here',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Discription here, describe task related issue here.  '
                'when start your task and when start'),
            SizedBox(
              height: 10,
            ),
            Text('23/10/2023'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'New',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  spacing: 15,
                  children: [
                    Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.green,
                    ),
                    Icon(
                      Icons.delete_forever_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
