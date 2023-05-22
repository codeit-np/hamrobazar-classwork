import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/controller/auth.dart';
import 'package:hamrobazar/controller/cart.dart';
import 'package:hamrobazar/controller/product.dart';
import 'package:hamrobazar/model/product.dart';
import 'package:hamrobazar/views/cart.dart';
import 'package:hamrobazar/views/login.dart';
import 'package:hamrobazar/views/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/category.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    var productController = Get.find<ProductController>();
    var cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hamro Bazar"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  cartController.getCartItems();
                  Get.to(() => const CartView());
                },
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    Obx(
                      () =>
                          Text("${cartController.products.value.data.length}"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            if (categoryController.isLoading.value == true) {
              return const Text("Loading....");
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthController.name == "null"
                          ? const Text("Hello Guest")
                          : Text("Hello ${AuthController.name}"),
                      AuthController.name == "null"
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () async {
                                Get.defaultDialog(
                                    title: "Logout",
                                    content: const Text(
                                        "Are you sure? you want to logout"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No")),
                                      ElevatedButton(
                                          onPressed: () async {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.remove("accessToken");
                                            preferences.remove("name");
                                            Get.offAll(
                                                () => const LoginScreen());
                                          },
                                          child: const Text("Yes"))
                                    ]);
                              },
                              child: Icon(Icons.logout)),
                      //List of Categories
                      SizedBox(
                        width: Get.size.width,
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              categoryController.categories.value.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var category =
                                categoryController.categories.value.data[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ActionChip(
                                onPressed: () {
                                  productController
                                      .getProductByCategory(category.id);
                                },
                                label: Text(
                                    "${category.name} (${category.products.length})"),
                              ),
                            );
                          },
                        ),
                      ),
                      // List of Products

                      const ListTile(
                        title: Text("Products List"),
                        subtitle: Text("List of Products provided by us"),
                      ),
                      GridView.builder(
                        itemCount: productController.products.value.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var product =
                              productController.products.value.data[index];
                          return ProductWidget(product: product);
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final Datum product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductView(
              productId: product.id,
              image: product.image,
              name: product.name,
              price: product.sellingPrice,
              description: product.description,
            ));
      },
      child: Card(
        elevation: .2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  Image.network(
                    "${product.image}",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: const Color.fromRGBO(0, 0, 0, .25),
                  ),
                  product.discount == 0
                      ? const SizedBox()
                      : Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.yellow,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Rs.${product.price}",
                              style: const TextStyle(
                                  fontSize: 8,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.name}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rs.${product.sellingPrice}"),
                      SizedBox(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            Text("5"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
