
class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String logIn = '$_baseUrl/login';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String getNewTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String getProgressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskCountSummaryList = '$_baseUrl/taskStatusCount';
  static  String updateTaskStatusUrl(id , status) => '$_baseUrl/updateTaskStatus/$id/$status';

}