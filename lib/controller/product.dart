import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/service/product.dart';

import '../model/product.dart';

class ProductController extends GetxController {
  var products = ProductModel(data: []).obs;
  var isLoading = false.obs;

  Future getProductByCategory(var id) async {
    try {
      isLoading(true);
      var data = await ProductService.getProductsByCategory(id);
      if (data != null) {
        products.value = data;
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProductByCategory(5);
  }
}
