import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/controller/auth.dart';
import 'package:hamrobazar/util/string.dart';

import '../model/cart.dart';

class CartService {
  static Future addToCart(Map data) async {
    try {
      var response =
          await AppString.client.post(Uri.parse("${AppString.baseURL}/cart"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${AuthController.accessToken}'
              },
              body: jsonEncode(data));
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['success'] == true) {
        Get.snackbar("Success", jsonData['message']);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

//Get Cart Items
  static Future getCartItems() async {
    try {
      var response = await AppString.client.get(
          Uri.parse("${AppString.baseURL}/cart"),
          headers: {'Authorization': 'Bearer ${AuthController.accessToken}'});
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return CartModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
