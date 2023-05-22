import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/controller/auth.dart';
import 'package:hamrobazar/util/string.dart';
import 'package:hamrobazar/views/home.dart';

class OrderService {
  static Future order(Map data) async {
    try {
      var response =
          await AppString.client.post(Uri.parse("${AppString.baseURL}/order"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${AuthController.accessToken}'
              },
              body: jsonEncode(data));
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        Get.defaultDialog(
            title: 'Order Successful',
            content: Text(jsonData['message']),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.off(() => const HomeView());
                  },
                  child: const Text("Ok"))
            ]);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
