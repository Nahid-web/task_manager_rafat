import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/task_list_model.dart';

import '../../data/utility/urls.dart';
import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';

class CanceledTasksScreen extends StatefulWidget {
  const CanceledTasksScreen({super.key});

  @override
  State<CanceledTasksScreen> createState() => _CanceledTasksScreenState();
}

class _CanceledTasksScreenState extends State<CanceledTasksScreen> {
  TaskListModel taskListModel = TaskListModel();
  bool isCanceledTaskProgress = false;
  Future<void> getCancelledTaskList() async {
    isCanceledTaskProgress = true;
    setState(() {

    });
   NetworkResponse response = await NetworkCaller().getRequest(Urls.getCancelledTaskList);
   if(response.isSuccess){
     taskListModel = TaskListModel.fromJson(response.jsonResponse);
   }
   isCanceledTaskProgress = false;
   setState(() {

   });
  }
  @override
  void initState() {
    getCancelledTaskList();
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
                onRefresh: getCancelledTaskList,
                child: Visibility(
                  visible: isCanceledTaskProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                            task: taskListModel.taskList![index],
                            onStatusChange: (){
                              getCancelledTaskList();
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
