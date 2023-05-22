class CategoryModel {
  CategoryModel({
    required this.data,
  });

  final List<Datum> data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
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
    required this.slug,
    required this.image,
    required this.description,
    required this.products,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? description;
  final List<Product> products;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      image: json["image"],
      description: json["description"],
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
