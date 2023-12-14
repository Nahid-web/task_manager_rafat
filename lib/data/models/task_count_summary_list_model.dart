class TaskCountSummaryListModel {
  String? status;
  List<TaskCount>? countSummary;

  TaskCountSummaryListModel({this.status, this.countSummary});

  TaskCountSummaryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      countSummary = <TaskCount>[];
      json['data'].forEach((v) {
        countSummary!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (countSummary != null) {
      data['data'] = countSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskCount {
  String? sId;
  int? sum;

  TaskCount({this.sId, this.sum});

  TaskCount.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
