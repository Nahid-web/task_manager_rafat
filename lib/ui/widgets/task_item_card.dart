import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';

import '../../data/models/task_list_model.dart';
import '../../data/utility/urls.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
  });

  final Task task;
  final VoidCallback onStatusChange;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatusUrl(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.task.description.toString()),
            const SizedBox(
              height: 10,
            ),
            Text('Date : ${widget.task.createdDate}'),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      widget.task.status.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  spacing: 15,
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModel();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        size: 30,
                        color: Colors.red,
                      ),
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

  void showUpdateStatusModel() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
              title: Text(e.name.toString()),
            ))
        .toList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            children: items,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }
}
