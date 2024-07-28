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
}
