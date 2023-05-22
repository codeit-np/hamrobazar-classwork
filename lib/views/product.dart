import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:hamrobazar/controller/auth.dart';
import 'package:hamrobazar/controller/cart.dart';
import 'package:hamrobazar/service/cart.dart';
import 'package:hamrobazar/views/login.dart';

class ProductView extends StatefulWidget {
  dynamic productId;
  dynamic image;
  dynamic name;
  dynamic price;
  dynamic description;

  ProductView({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: Get.size.width,
                height: 200,
                child: Image.network(
                  "${widget.image}",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
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
              Row(
                children: [
                  Text(
                    "Rs.${widget.price}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Text("${widget.description}"),
              SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                      child: Html(data: widget.description))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              qty--;
                              if (qty < 1) {
                                qty = 1;
                              }
                              setState(() {});
                            },
                            child: const Icon(Icons.remove)),
                        Text(
                          '$qty',
                          style: const TextStyle(fontSize: 24),
                        ),
                        GestureDetector(
                            onTap: () {
                              qty++;
                              setState(() {});
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                  FilledButton(
                      onPressed: () async {
                        print(AuthController.accessToken);
                        // ignore: unnecessary_null_comparison
                        if (AuthController.accessToken == 'null') {
                          Get.to(() => const LoginScreen());
                        } else {
                          Map data = {
                            "product_id": widget.productId,
                            "qty": qty,
                            "price": widget.price
                          };

                          Loader.show(context);
                          await CartService.addToCart(data);
                          await cartController.getCartItems();
                          Loader.hide();
                        }
                      },
                      child: const Text("ADD TO CART"))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
