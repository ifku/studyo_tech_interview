import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/core/theme/app_colors.dart';
import 'package:studyo_tech_interview/presentation/controllers/user_list_controller.dart';
import 'package:studyo_tech_interview/presentation/pages/edit_user_page.dart';

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
                      Get.to(() => const EditUserPage());
                    },
                  );
                },
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
