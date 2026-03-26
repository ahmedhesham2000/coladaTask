class CartModel {
  String id;
  String name;
  String image;
  int quantity;
  double price;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'quantity': quantity,
    'price': price,
  };

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    image: json['image'] as String? ?? '',
    quantity: json['quantity'] as int,
    price: (json['price'] as num).toDouble(),
  );
}
