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
  final RxBool isAvailable = true.obs;
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
  * - Check if the username is available and not used by other users.
  * - This function is called when the user types in the username field.
  * - It validates the username and checks if it is available.
  * */
  Future<bool> checkUserAvailability(String username) async {
    final result = await userRepository.checkUserAvailability(username);
    return result.fold(
      (l) {
        error.value = l.toString();
        return false;
      },
      (r) {
        isAvailable.value = r;
        log('checkUserAvailability: $r', name: "Edit User Controller");
        return r;
      },
    );
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

      bool isAvailable = await checkUserAvailability(username);

      if (isAvailable) {
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
  }
}
