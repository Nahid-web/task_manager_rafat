import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/task_list_model.dart';

import '../../data/utility/urls.dart';
import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  TaskListModel taskListModel = TaskListModel();
  bool isCompletedProgress = false;

  Future<void> getCompletedTaskList() async {
    isCompletedProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTaskList);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    isCompletedProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryTile(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: getCompletedTaskList,
                child: Visibility(
                  visible: isCompletedProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                            task: taskListModel.taskList![index],
                            onStatusChange: () {
                              getCompletedTaskList();
                            });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
