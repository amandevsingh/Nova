import 'dart:convert';

List<TaskListModel> taskListModelListFromJson(String str) =>
    List<TaskListModel>.from(
        json.decode(str).map((x) => TaskListModel.fromJson(x)));
TaskListModel taskListModelFromJson(String str) =>
    TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
  TaskListModel({
    this.title,
    this.description,
    this.isExpand,
  });

  String title;
  String description;
  bool isExpand;

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        title: json["title"],
        description: json["description"],
        isExpand: json["isExpand"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "isExpand": isExpand,
      };
}
