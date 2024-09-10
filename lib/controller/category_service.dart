import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/controller/task_service.dart';
import 'package:d5n_interview/model/category_model.dart';
import 'package:d5n_interview/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryService {
  final CollectionReference<UserModel> userCollection =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: UserModel.fromFirebase,
            toFirestore: (UserModel value, options) => value.toFirestore(),
          );

  Stream<QuerySnapshot<CategoryModel>> getCategories(String id) {
    return userCollection
        .doc(id)
        .collection("category")
        .withConverter(
          fromFirestore: CategoryModel.fromFirebase,
          toFirestore: (CategoryModel category, options) =>
              category.toFirestore(),
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<CategoryModel>> getCategory(
      String id, String categoryId) {
    return userCollection
        .doc(id)
        .collection("category")
        .withConverter(
          fromFirestore: CategoryModel.fromFirebase,
          toFirestore: (CategoryModel category, options) =>
              category.toFirestore(),
        )
        .doc(categoryId)
        .snapshots();
  }

  Future<DocumentReference<CategoryModel>> addCategory(
      String id, String name, String emoji) {
    return userCollection
        .doc(id)
        .collection("category")
        .withConverter(
          fromFirestore: CategoryModel.fromFirebase,
          toFirestore: (CategoryModel contact, options) =>
              contact.toFirestore(),
        )
        .add(CategoryModel(categoryname: name, emoji: emoji, tasks: 0));
  }

  Future<void> deleteCategory(String id, String categoryId) {
    return userCollection
        .doc(id)
        .collection("category")
        .doc(categoryId)
        .delete();
  }
}

final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});
final getCategoriesProvider =
    StreamProvider<QuerySnapshot<CategoryModel>?>((ref) {
  return ref.watch(authStateProvider).value == null
      ? const Stream.empty()
      : ref
          .read(categoryServiceProvider)
          .getCategories(ref.read(authStateProvider).value!.uid);
});
final getCategoryProvider =
    StreamProvider<DocumentSnapshot<CategoryModel>>((ref) {
  var authState = ref.watch(authStateProvider);
  var categoryId = ref.watch(getCategoryIdProvider);

  return authState.value == null
      ? const Stream.empty()
      : ref
          .read(categoryServiceProvider)
          .getCategory(authState.value!.uid, categoryId!);
});
