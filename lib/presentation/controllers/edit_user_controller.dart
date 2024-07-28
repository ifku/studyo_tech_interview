import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/domain/repository/user_repository.dart';

class EditUserController extends GetxController {
  final UserRepository userRepository = Get.find<UserRepository>();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString username = ''.obs;
  final RxBool isReview = false.obs;

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
}
