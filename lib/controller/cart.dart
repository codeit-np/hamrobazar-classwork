import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/service/cart.dart';

import '../model/cart.dart';

class CartController extends GetxController {
  var products = CartModel(data: []).obs;
  var isLoading = false.obs;

  Future getCartItems() async {
    try {
      isLoading(true);
      var data = await CartService.getCartItems();
      if (data != null) {
        products.value = data;
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      isLoading(false);
    }
  }
}
