import 'package:get/get.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/task_list_model.dart';
import 'package:task_manager_rafat/data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get getTaskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTaskList);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    _getNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
