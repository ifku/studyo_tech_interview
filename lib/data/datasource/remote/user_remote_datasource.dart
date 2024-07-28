import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

class UserRemoteDatasource implements UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<Either<Exception, List<UserModel>>> fetchAllUsers() {
    final CollectionReference users = firestore.collection('users');
    return users.snapshots().map((querySnapshot) {
      try {
        log('fetchAllUsers: ${querySnapshot.docs.length}',
            name: "User Data Source");
        final List<UserModel> userList = querySnapshot.docs
            .map(
                (doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        return Right<Exception, List<UserModel>>(userList);
      } catch (e) {
        return Left<Exception, List<UserModel>>(Exception(e.toString()));
      }
    }).handleError((error) {
      return Left<Exception, List<UserModel>>(Exception(error.toString()));
    });
  }

  @override
  Future<Either<Exception, bool>> createUser(String username) async {
    final CollectionReference user = firestore.collection('users');
    final userId = const Uuid().v4();
    try {
      await user
          .add({'userId': userId, 'username': username, 'isReview': true});
      return const Right<Exception, bool>(true);
    } catch (e) {
      return Left<Exception, bool>(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, UserModel>> fetchUserById(String id) async {
    final CollectionReference user = firestore.collection('users');
    final querySnapshot = await user.where('userId', isEqualTo: id).get();
    try {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final UserModel userModel =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);
        return Right<Exception, UserModel>(userModel);
      } else {
        return Left<Exception, UserModel>(Exception('User not found'));
      }
    } catch (e) {
      return Left<Exception, UserModel>(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, bool>> updateUser(String username) async {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
