import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

// Getx used for state management.
class EditUserController extends GetxController {
  final UserRepository userRepository = Get.find<UserRepository>();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString username = ''.obs;
  final RxBool isReview = false.obs;
  final RxString validationError = ''.obs;
  final TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserById(Get.arguments['userId']!);
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  /*
  * - Fetch user data by user id, from Firebase Firestore.
  * - This function is called when the controller is initialized.
  * - It fetches the user data by user id and sets the username and isReview values.
  *  */
  void fetchUserById(String userId) {
    isLoading.value = true;
    error.value = '';
    userRepository.fetchUserById(userId).then(
      (result) {
        result.fold(
          (l) {
            error.value = l.toString();
          },
          (r) {
            log('fetchUserById: ${r.username}', name: "Edit User Controller");
            username.value = r.username;
            isReview.value = r.isReview;
            usernameController.text = r.username;
          },
        );
      },
    ).whenComplete(() => isLoading.value = false);
  }

  /*
  * -  Update user data by user id, from Firebase Firestore.
  * -  This function is called when the user submits the form.
  * -  It validates the form and checks if the username is available.
   */
  Future<void> updateUser(String id, String username) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      error.value = '';
      validationError.value = '';
      final isAvailable = await isUsernameAvailable(usernameController.text);
      if (!isAvailable) {
        validationError.value = "Username is already taken";
        isLoading.value = false;
        return;
      }
      final result = await userRepository.updateUser(id, username);
      result.fold(
        (l) {
          error.value = l.toString();
        },
        (r) {
          log('updateUser: $r', name: "Edit User Controller");
          Get.back();
        },
      );
    } else {
      error.value = "Username is not available";
    }
    isLoading.value = false;
  }

  Future<bool> isUsernameAvailable(String username) async {
    final result = await userRepository.checkUserAvailability(username);
    return result.fold(
      (failure) {
        log('Error checking username: $failure');
        return false;
      },
      (isAvailable) => !isAvailable,
    );
  }
}
