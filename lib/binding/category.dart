import 'package:get/get.dart';
import 'package:hamrobazar/controller/auth.dart';
import 'package:hamrobazar/controller/cart.dart';
import 'package:hamrobazar/controller/product.dart';

import '../controller/category.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(AuthController());
    Get.put(CartController());
  }
}
