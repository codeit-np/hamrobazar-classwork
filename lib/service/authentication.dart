import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/util/string.dart';
import 'package:hamrobazar/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future login(Map data) async {
    try {
      var response = await AppString.client.post(
          Uri.parse("${AppString.baseURL}/login"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(data));
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("accessToken", jsonData['token'].toString());
        preferences.setString("name", jsonData['user']['name'].toString());

        Get.off(() => const HomeView());
      } else {
        //login failure
        Get.defaultDialog(
          title: 'Login failure',
          content: Text(jsonData['message']),
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK")),
        );
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
