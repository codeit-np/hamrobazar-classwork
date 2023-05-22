import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/category.dart';
import '../util/string.dart';

class CategoryService {
  static Future getCategories() async {
    try {
      var response = await AppString.client
          .get(Uri.parse("${AppString.baseURL}/categories"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return CategoryModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
