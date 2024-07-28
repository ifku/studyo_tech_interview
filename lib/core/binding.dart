import 'package:get/get.dart';
import 'package:studyo_tech_interview/data/datasource/remote/user_remote_datasource.dart';
import 'package:studyo_tech_interview/data/datasource/user_datasource.dart';
import 'package:studyo_tech_interview/data/repository/user_repository_impl.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';
import 'package:studyo_tech_interview/presentation/controllers/user_list_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDatasource>(() => UserRemoteDatasource());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    Get.lazyPut(() => UserListController());
  }
}
