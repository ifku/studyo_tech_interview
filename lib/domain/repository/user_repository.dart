import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';

/*
* - UserRepository is an abstract class that contains methods to interact with the user data source.
* - fetchAllUsers() is a method that returns a stream of Either<Exception, List<UserEntity>>.
* - fetchUserById() is a method that returns a Future of Either<Exception, UserEntity>.
* - createUser() is a method that returns a Future of Either<Exception, bool>.
* - updateUser() is a method that returns a Future of Either<Exception, bool>.
* - checkUserAvailability() is a method that returns a Future of Either<Exception, bool>.
* */
abstract class UserRepository {
  Stream<Either<Exception, List<UserEntity>>> fetchAllUsers();

  Future<Either<Exception, UserEntity>> fetchUserById(String id);

  Future<Either<Exception, bool>> createUser(String username);

  Future<Either<Exception, bool>> updateUser(String id, String username);

  Future<Either<Exception, bool>> checkUserAvailability(String username);
}
