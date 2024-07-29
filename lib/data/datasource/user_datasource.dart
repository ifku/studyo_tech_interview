import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/data/model/user_model.dart';

/*
* - UserDatasource is an abstract class that contains abstract methods to fetch all users, fetch user by id, create user, update user, and check user availability.
* - fetchAllUsers() method returns a Stream of List of UserModel wrapped in Either of Exception.
* - fetchUserById() method returns a Future of UserModel wrapped in Either of Exception.
* - createUser() method returns a Future of bool wrapped in Either of Exception.
* - updateUser() method returns a Future of bool wrapped in Either of Exception.
* */
abstract class UserDatasource {
  Stream<Either<Exception, List<UserModel>>> fetchAllUsers();

  Future<Either<Exception, UserModel>> fetchUserById(String id);

  Future<Either<Exception, bool>> createUser(String username);

  Future<Either<Exception, bool>> updateUser(String id, String username);

  Future<Either<Exception, bool>> checkUserAvailability(String username);
}
