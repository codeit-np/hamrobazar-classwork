import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/views/home.dart';
import 'package:hamrobazar/views/login.dart';

import '../controller/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkAuth() async {
    await AuthController.getUserDetail();
    debugPrint(AuthController.accessToken);
    // ignore: unnecessary_null_comparison
    if (AuthController.accessToken != "null") {
      Future.delayed(const Duration(seconds: 3), () {
        Get.off(() => const HomeView());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.off(() => const LoginScreen());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 40,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: const Text(
            "App version: 1.0",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        body: const Center(
          child: Text("Hamro Bazar"),
        ),
      ),
    );
  }
}
