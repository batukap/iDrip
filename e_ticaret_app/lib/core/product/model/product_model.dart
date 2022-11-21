class ProductModel {
  int? id;
  String? categoryId;
  String? name;
  String? image;
  String? votes;
  String? price;
  String? createdAt;
  String? updatedAt;
  bool isSaved = false;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.votes,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.isSaved = false,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id']?.toInt();
    categoryId = json['category_id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    votes = json['votes']?.toString();
    price = json['price']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['votes'] = votes;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
