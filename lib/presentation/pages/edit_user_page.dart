import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/core/theme/app_colors.dart';
import 'package:studyo_tech_interview/presentation/controllers/edit_user_controller.dart';
import 'package:studyo_tech_interview/presentation/pages/custom_profile_status.dart';
import 'package:studyo_tech_interview/presentation/widgets/custom_confirm_button.dart';

class EditUserPage extends GetView<EditUserController> {
  const EditUserPage({super.key});

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                        color: AppColors.purple500,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const CustomProfileStatus(isReview: false),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card.outlined(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 36.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Username",
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 48.0),
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
                                labelStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                label: const Text("Username"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 48.0),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomConfirmButton(
                        onPressed: () {
                          if (controller.formKey.currentState != null) {
                            controller.formKey.currentState!.validate();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
