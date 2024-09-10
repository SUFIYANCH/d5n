import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/model/task_model.dart';
import 'package:d5n_interview/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskService {
  final CollectionReference<UserModel> userCollection =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: UserModel.fromFirebase,
            toFirestore: (UserModel value, options) => value.toFirestore(),
          );

  Stream<QuerySnapshot<TaskModel>> gettask(String uid, String categoryId) {
    return userCollection
        .doc(uid)
        .collection("category")
        .doc(categoryId)
        .collection("task")
        .withConverter(
          fromFirestore: TaskModel.fromFirebase,
          toFirestore: (TaskModel value, options) => value.toFirestore(),
        )
        .snapshots();
  }

  Future<void> addTask(String uid, String categoryId, TaskModel data) async {
    await userCollection
        .doc(uid)
        .collection("category")
        .doc(categoryId)
        .collection("task")
        .withConverter(
          fromFirestore: TaskModel.fromFirebase,
          toFirestore: (TaskModel value, options) => value.toFirestore(),
        )
        .add(data);
    await userCollection
        .doc(uid)
        .collection('category')
        .doc(categoryId)
        .update({
      'tasks': FieldValue.increment(1),
    });
  }

  Future<void> toggleTaskStatus(
      String userId, String categoryId, String taskId, bool isDone) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('category')
        .doc(categoryId)
        .collection('task')
        .doc(taskId)
        .update({'isDone': !isDone});
  }

  Future<void> deleteTask(
      String userId, String categoryId, String taskId) async {
    await userCollection
        .doc(userId)
        .collection('category')
        .doc(categoryId)
        .collection('task')
        .doc(taskId)
        .delete();
    await userCollection
        .doc(userId)
        .collection('category')
        .doc(categoryId)
        .update({
      'tasks': FieldValue.increment(-1),
    });
  }
}

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});
final getCategoryIdProvider = StateProvider<String?>((ref) {
  return null;
});
final getTaskProvider = StreamProvider<QuerySnapshot<TaskModel>>((ref) {
  var uid = ref.watch(authStateProvider).value?.uid;
  var categoryId = ref.watch(getCategoryIdProvider);
  return uid == null
      ? const Stream.empty()
      : ref.read(taskServiceProvider).gettask(uid, categoryId!);
});
