import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

class UserListController extends GetxController {
  final UserRepository userRepository = Get.find<UserRepository>();
  final RxList<UserEntity> users = <UserEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  StreamSubscription? _userSubscription;
  final TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  @override
  void onClose() {
    _userSubscription?.cancel();
    usernameController.dispose();
    super.onClose();
  }

  void fetchAllUsers() {
    isLoading.value = true;
    error.value = '';
    _userSubscription = userRepository.fetchAllUsers().listen(
      (result) {
        result.fold(
          (failure) {
            error.value = failure.toString();
            isLoading.value = false;
          },
          (userList) {
            users.value = userList;
            isLoading.value = false;
            log('fetchAllUsers: ${users.length}', name: "User List Controller");
          },
        );
      },
      onError: (e) {
        error.value = e.toString();
        isLoading.value = false;
      },
    );
  }

  void createUser() {
    if (formKey.currentState!.validate()) {
      userRepository.createUser(usernameController.text).then(
        (result) {
          result.fold(
            (failure) {
              error.value = failure.toString();
            },
            (success) {
              usernameController.clear();
            },
          );
        },
      );
    }
  }
}
