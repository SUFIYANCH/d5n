import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  UserModel({
    required this.name,
    required this.email,
  });

  factory UserModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?["name"],
      email: data?["email"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
    };
  }
}
