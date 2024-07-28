import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';

abstract class UserRepository {
  Stream<Either<Exception, List<UserEntity>>> fetchAllUsers();
}