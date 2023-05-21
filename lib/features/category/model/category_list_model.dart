class CategoryListModel {
  final String? name;
  final String? isActive;
  final String? productCount;
  final String? id;
  final String? position;
  final String? childrenData;

  CategoryListModel(
      {this.id,
      this.name,
      this.isActive,
      this.childrenData,
      this.position,
      this.productCount});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      position: json['position'],
      productCount: json['product_count'],
      childrenData: json['children_data'][0]
    );
  }
}
