import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/model/category.dart';
import 'package:hamrobazar/service/category.dart';

class CategoryController extends GetxController {
  var categories = CategoryModel(data: []).obs;
  var isLoading = false.obs;

  Future getCategories() async {
    try {
      isLoading(true);
      var data = await CategoryService.getCategories();
      if (data != null) {
        categories.value = data;
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
    getCategories();
  }
}
