class HomeProduct {
  HomeProduct({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.quantity = 0,
  });

  int id;
  String name;
  String? description;
  double price;
  int quantity;
}
