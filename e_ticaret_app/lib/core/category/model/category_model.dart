class CategoryModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });
  CategoryModel.fromJson(dynamic json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
