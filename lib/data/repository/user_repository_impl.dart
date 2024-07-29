import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

/*
* - UserRepositoryImpl is the implementation of UserRepository
* - It uses UserDatasource to fetch data from the server
* - It uses Get to find the UserDatasource instance
* - It implements all the methods of UserRepository
* - It returns the data from the datasource
* - It returns the data in the form of Either<Exception, T>
* */
class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDataSource = Get.find<UserDatasource>();

  @override
  Stream<Either<Exception, List<UserEntity>>> fetchAllUsers() {
    return userDataSource.fetchAllUsers();
  }

  @override
  Future<Either<Exception, bool>> createUser(String username) async {
    return userDataSource.createUser(username);
  }

  @override
  Future<Either<Exception, UserEntity>> fetchUserById(String id) async {
    return userDataSource.fetchUserById(id);
  }

  @override
  Future<Either<Exception, bool>> updateUser(String id, String username) async {
    return userDataSource.updateUser(id, username);
  }

  @override
  Future<Either<Exception, bool>> checkUserAvailability(String username) async {
    return userDataSource.checkUserAvailability(username);
  }
}
