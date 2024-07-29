import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/domain/entity/user_entity.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

// Getx used for state management.
class UserListController extends GetxController {
  final UserRepository userRepository = Get.find<UserRepository>();
  final RxList<UserEntity> users = <UserEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isAvailable = true.obs;
  final RxString error = ''.obs;
  StreamSubscription? _userSubscription;
  final TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /*
    * Fetch all users from Firebase Firestore.
    * This function is called when the controller is initialized.
    * It listens to the stream of users from the UserRepository.
   */
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

  Future<bool> checkUserAvailability(String username) async {
    final result = await userRepository.checkUserAvailability(username);
    return result.fold(
      (l) {
        error.value = l.toString();
        return false;
      },
      (r) {
        isAvailable.value = r;
        log('checkUserAvailability: $r', name: "User List Controller");
        return r;
      },
    );
  }

  Future<void> createUser() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      error.value = '';

      bool isUserAvailable = await checkUserAvailability(usernameController.text);
      log('checkUserAvailability: $isUserAvailable', name: "User List Controller");


      if (isUserAvailable) {
        final result = await userRepository.createUser(usernameController.text);
        result.fold(
          (failure) {
            error.value = failure.toString();
          },
          (success) {
            usernameController.clear();
          },
        );
      } else {
        isLoading.value = false;
      }

      isLoading.value = false;
    }
  }
}
