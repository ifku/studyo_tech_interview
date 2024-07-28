import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/data/model/user_model.dart';

class UserRemoteDatasource implements UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<Either<Exception, List<UserModel>>> fetchAllUsers() {
    final CollectionReference users = firestore.collection('users');
    return users.snapshots().map((querySnapshot) {
      try {
        log('fetchAllUsers: ${querySnapshot.docs.length}', name: "User Data Source");
        final List<UserModel> userList = querySnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        return Right<Exception, List<UserModel>>(userList);
      } catch (e) {
        return Left<Exception, List<UserModel>>(Exception(e.toString()));
      }
    }).handleError((error) {
      return Left<Exception, List<UserModel>>(Exception(error.toString()));
    });
  }
}