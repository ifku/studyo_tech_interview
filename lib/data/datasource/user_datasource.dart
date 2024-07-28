import 'package:fpdart/fpdart.dart';
import 'package:studyo_tech_interview/data/model/user_model.dart';

abstract class UserDatasource {
  Stream<Either<Exception, List<UserModel>>> fetchAllUsers();
}