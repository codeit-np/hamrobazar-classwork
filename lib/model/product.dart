class ProductModel {
  ProductModel({
    required this.data,
  });

  final List<Datum> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.discountAmount,
    required this.sellingPrice,
    required this.description,
    required this.image,
    required this.category,
    required this.published,
  });

  final int? id;
  final String? name;
  final int? price;
  final int? discount;
  final int? discountAmount;
  final int? sellingPrice;
  final String? description;
  final String? image;
  final String? category;
  final String? published;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      discount: json["discount"],
      discountAmount: json["discount_amount"],
      sellingPrice: json["selling_price"],
      description: json["description"],
      image: json["image"],
      category: json["category"],
      published: json["published"],
    );
  }
}
