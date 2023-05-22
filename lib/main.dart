import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/views/login.dart';
import 'package:hamrobazar/views/splash.dart';

import 'binding/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hamro Bazar',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      initialBinding: CategoryBinding(),
      home: const SplashScreen(),
    );
  }
}
