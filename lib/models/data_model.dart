class ItemModel {
  late String name;
  late int price;
  late String category;
  late String description;

  ItemModel(
      {required this.name,
      required this.price,
      required this.category,
      required this.description});

  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    price = json['price'];
    category = json['category'] ?? "";
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    data['description'] = this.description;
    return data;
  }
}
