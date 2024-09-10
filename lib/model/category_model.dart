import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String categoryname;
  String emoji;
  int? tasks;
  CategoryModel({required this.categoryname, required this.emoji, this.tasks});

  factory CategoryModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CategoryModel(
      categoryname: data?["categoryname"],
      emoji: data?["emoji"],
      tasks: data?["tasks"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "categoryname": categoryname,
      "emoji": emoji,
      "tasks": tasks,
    };
  }
}
