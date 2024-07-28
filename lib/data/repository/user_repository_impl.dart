import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

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
  Future<Either<Exception, bool>> updateUser(String username) async {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
