import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/controller/cart.dart';

import '../service/order.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            child: ElevatedButton(
                onPressed: () async {
                  Map data = {
                    "total": 50100,
                    "products": cartController.products.value.data.map((p) {
                      return {
                        "id": p.id,
                        "product_id": p.productId,
                        "product_title": p.productTitle,
                        "image": p.image,
                        "qty": p.qty,
                        "rate": p.rate,
                        "amount": p.amount
                      };
                    }).toList()
                  };

                  Loader.show(context);
                  await OrderService.order(data);
                  await cartController.getCartItems();
                  Loader.hide();
                },
                child: const Text("Place Order")),
          ),
          appBar: AppBar(),
          body: Obx(() {
            if (cartController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: cartController.products.value.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var product =
                              cartController.products.value.data[index];
                          return ListTile(
                            leading: SizedBox(
                                width: 80,
                                height: 100,
                                child: Image.network("${product.image}")),
                            title: Text("${product.productTitle}"),
                            subtitle: Row(
                              children: [
                                Text(
                                    "${product.qty} x ${product.rate} = ${product.amount}")
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              );
            }
          })),
    );
  }
}
