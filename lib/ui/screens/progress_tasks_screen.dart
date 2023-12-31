import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/task_list_model.dart';

import '../../data/utility/urls.dart';
import '../widgets/profile_summary_tile.dart';
import '../widgets/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  bool isProgressTaskProgress = false;
  Future<void> getProgressTaskList() async {
    isProgressTaskProgress = true;
    setState(() {

    });
   NetworkResponse response  = await NetworkCaller().getRequest(Urls.getProgressTaskList);
   if(response.isSuccess){
     taskListModel = TaskListModel.fromJson(response.jsonResponse);
     setState(() {

     });
   }
   isProgressTaskProgress = false;
   setState(() {

   });
  }

  @override
  void initState() {
    getProgressTaskList();
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
              child: Visibility(
                visible: isProgressTaskProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskItemCard(task: taskListModel.taskList![index],
                            onStatusChange: (){
                          getProgressTaskList();
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
