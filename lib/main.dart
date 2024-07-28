import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyo_tech_interview/core/binding.dart';
import 'package:studyo_tech_interview/firebase_options.dart';
import 'package:studyo_tech_interview/presentation/pages/user_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(GetMaterialApp(
    initialBinding: InitialBinding(),
    debugShowCheckedModeBanner: false,
    home: const UserListPage(),
  ));
}
