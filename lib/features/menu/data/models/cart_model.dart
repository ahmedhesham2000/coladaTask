class CartModel {
  String id;
  String nameAr;
  String nameEn;
  String image;
  int quantity;
  double price;

  CartModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'image': image,
    'quantity': quantity,
    'price': price,
  };

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] as String,
    nameAr: json['nameAr'] as String? ?? '',
    nameEn: json['nameEn'] as String? ?? '',
    image: json['image'] as String? ?? '',
    quantity: json['quantity'] as int,
    price: (json['price'] as num).toDouble(),
  );
}
