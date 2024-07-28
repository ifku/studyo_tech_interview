import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';

abstract class UserRepository {
  Stream<Either<Exception, List<UserEntity>>> fetchAllUsers();

  Future<Either<Exception, UserEntity>> fetchUserById(String id);

  Future<Either<Exception, bool>> createUser(String username);

  Future<Either<Exception, bool>> updateUser(String username);
}
