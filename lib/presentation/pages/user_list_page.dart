import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/core/theme/app_colors.dart';
import 'package:studyo_tech_interview/presentation/controllers/user_list_controller.dart';
import 'package:studyo_tech_interview/presentation/pages/edit_user_page.dart';
import 'package:studyo_tech_interview/presentation/widgets/custom_confirm_button.dart';

class UserListPage extends GetView<UserListController> {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cyan100, AppColors.magenta500],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.error.isNotEmpty) {
              return Center(child: Text(controller.error.value));
            } else {
              return ListView.builder(
                itemCount: controller.users.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return ListTile(
                    title: Text(user.username),
                    onTap: () {
                      Get.to(() => const EditUserPage(), arguments: {'userId': user.userId});
                    },
                  );
                },
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  color: AppColors.cyan100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add User",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16.0),
                      Form(
                        key: controller.formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username cannot be empty";
                            } else if (value.length < 8) {
                              return "Minimum 8 characters";
                            } else if (!RegExp(r'^[a-zA-Z0-9]+$')
                                .hasMatch(value)) {
                              return "Use characters and numbers only";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.usernameController,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            label: const Text("Username"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(child: CustomConfirmButton(onPressed: () {
                        log(controller.usernameController.text,
                            name: "Username");
                        if (controller.formKey.currentState != null) {
                          controller.formKey.currentState!.validate();
                          controller.createUser();
                          Get.back();
                        }
                      }))
                    ],
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
