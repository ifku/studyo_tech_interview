import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

/*
* - UserRemoteDatasource is a concrete class that implements UserDatasource.
* - It contains methods to fetch all users, fetch user by id, create user, update user, and check user availability.
* - fetchAllUsers() method returns a Stream of List of UserModel wrapped in Either of Exception.
* - fetchUserById() method returns a Future of UserModel wrapped in Either of Exception.
* - createUser() method returns a Future of bool wrapped in Either of Exception.
* - updateUser() method returns a Future of bool wrapped in Either of Exception.
* - checkUserAvailability() method returns a Future of bool wrapped in Either of Exception.
* */
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
          .add({'userId': userId, 'username': username, 'isReview': false});
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
  Future<Either<Exception, bool>> updateUser(String id, String username) async {
    final CollectionReference users = firestore.collection('users');
    final querySnapshot = await users.where('userId', isEqualTo: id).get();

    try {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        await doc.reference.update({'username': username, 'isReview': true});
        return const Right(true);
      } else {
        return Left(Exception('User not found'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, bool>> checkUserAvailability(String username) async {
    final CollectionReference users = firestore.collection('users');
    try {
      final querySnapshot = await users.where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        return const Right<Exception, bool>(true);
      } else {
        return const Right<Exception, bool>(false);
      }
    } catch (e) {
      return Left<Exception, bool>(Exception(e.toString()));
    }
  }
}
