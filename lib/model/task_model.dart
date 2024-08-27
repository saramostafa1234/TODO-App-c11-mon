import 'package:todo_app_c11_mon/core/utils.dart';

class TaskModel {
  static const String collectionName = "TasksCollection";
  String? id;
  String title;
  String description;
  DateTime selectionDate;
  bool isDone;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.selectionDate,
    this.isDone = false,
  });

  factory TaskModel.firestore(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        selectionDate:
            DateTime.fromMillisecondsSinceEpoch(json["selectionDate"]),
        isDone: json["isDone"],
      );

//   factory TaskModel.firestore(Map<String, dynamic> json) {
//     return TaskModel(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       selectionDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
//       isDone: json["isDone"],
//     );
//   }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "selectionDate": extractDate(selectionDate).millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
