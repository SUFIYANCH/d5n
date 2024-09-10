import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String taskname;
  bool isDone;
  TaskModel({required this.taskname, required this.isDone});

  factory TaskModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskModel(
      taskname: data?["taskname"],
      isDone: data?["isDone"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "taskname": taskname,
      "isDone": isDone,
    };
  }
}
