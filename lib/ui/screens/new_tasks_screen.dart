import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/task_count_summary_list_model.dart';
import 'package:task_manager_rafat/data/models/task_list_model.dart';
import 'package:task_manager_rafat/ui/controller/new_task_controller.dart';
import 'package:task_manager_rafat/ui/screens/add_new_task_screen.dart';

import '../../data/utility/urls.dart';
import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';
import '../widgets/tasks_summary_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool isNewTaskProgress = false;
  TaskCountSummaryListModel taskCountSummaryListModel =
      TaskCountSummaryListModel();
  bool isTaskCountSummaryProgress = false;
  NewTaskController newTaskController = Get.find<NewTaskController>();

  Future<void> getTaskSummaryList() async {
    isTaskCountSummaryProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskCountSummaryList);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    isTaskCountSummaryProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    Get.find<NewTaskController>().getNewTaskList();
    getTaskSummaryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryTile(),
            GetBuilder<NewTaskController>(builder: (newTaskController) {
              return Visibility(
                visible: newTaskController.getNewTaskInProgress == false,
                replacement: const LinearProgressIndicator(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 120,
                  child: ListView.builder(
                    itemCount:
                        taskCountSummaryListModel.countSummary?.length ?? 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      TaskCount taskSummary =
                          taskCountSummaryListModel.countSummary![index];
                      return FittedBox(
                          child: TasksSummaryCard(
                        count: taskSummary.sum.toString(),
                        tittle: taskSummary.sId.toString(),
                      ));
                    },
                  ),
                ),
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => newTaskController.getNewTaskList(),
                child: Visibility(
                  visible: isNewTaskProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount:
                          newTaskController.getTaskListModel.taskList?.length ??
                              0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: newTaskController
                              .getTaskListModel.taskList![index],
                          onStatusChange: () {
                            newTaskController.getNewTaskList();
                            getTaskSummaryList();
                          },
                        );
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
