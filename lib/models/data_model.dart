class ItemModel {
   String? name;
   String? price;
   String? image;
   String? category;
   String? description;

  ItemModel(
      { this.name,
       this.price,
       this.image,
       this.category,
       this.description});

  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    price = json['price'] ?? "";
    image = json['image'] ?? "";
    category = json['category'] ?? "";
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['category'] = this.category;
    data['description'] = this.description;
    return data;
  }
}
