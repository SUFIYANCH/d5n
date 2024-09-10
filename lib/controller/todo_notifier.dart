// import 'package:d5n_interview/model/todo_model.dart';
// import 'package:flutter/material.dart';

// class TodoNotifier extends ChangeNotifier {
//   final List<TodoModel> _categoryList = [];
//   final List<TodoModel> _taskList = [];

//   List<TodoModel> get categoryList {
//     return _categoryList;
//   }

//   List<TodoModel> get taskList {
//     return _taskList;
//   }

//   void addcategory(TodoModel category) {
//     _categoryList.add(category);
//     notifyListeners();
//   }

//   void deletecategory(int index) {
//     _categoryList.removeAt(index);
//     notifyListeners();
//   }

//   void addtask(TodoModel task) {
//     _taskList.add(task);
//     notifyListeners();
//   }

//   void deletetask(int index) {
//     _taskList.removeAt(index);
//     notifyListeners();
//   }

//   void isdone(int index) {
//     _taskList[index].isDone = !_taskList[index].isDone;
//     notifyListeners();
//   }
// }
