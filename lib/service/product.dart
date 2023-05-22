import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/product.dart';
import '../util/string.dart';

class ProductService {
  static Future getProductsByCategory(var id) async {
    try {
      var response = await AppString.client
          .get(Uri.parse("${AppString.baseURL}/category/$id"));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return ProductModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
