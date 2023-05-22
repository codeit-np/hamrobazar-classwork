class CartModel {
  CartModel({
    required this.data,
  });

  final List<Datum> data;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.image,
    required this.qty,
    required this.rate,
    required this.amount,
  });

  final int? id;
  final int? productId;
  final String? productTitle;
  final String? image;
  final int? qty;
  final int? rate;
  final int? amount;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      productId: json["product_id"],
      productTitle: json["product_title"],
      image: json["image"],
      qty: json["qty"],
      rate: json["rate"],
      amount: json["amount"],
    );
  }
}
