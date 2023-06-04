class CategoryModel {
  final String? name;
  final bool? isActive;
  final int? id;
  final List<SubCategoryModel>? subCategoryModel;

  CategoryModel({
    this.id,
    this.name,
    this.isActive,
    this.subCategoryModel,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        name: json['name'],
        isActive: json['is_active'],
        subCategoryModel: json['children_data']
            .map<SubCategoryModel>(
                (dataJson) => SubCategoryModel.fromJson(dataJson))
            .toList());
  }
}

class SubCategoryModel {
  final String? name;
  final bool? isActive;
  final int? id;
  final List<SubCategoryChildModel>? subCategoryChildModel;

  SubCategoryModel(
      {this.id, this.name, this.isActive, this.subCategoryChildModel});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
        id: json['id'],
        name: json['name'],
        isActive: json['is_active'],
        subCategoryChildModel: json['children_data']
            .map<SubCategoryChildModel>(
                (dataJson) => SubCategoryChildModel.fromJson(dataJson))
            .toList());
  }
}

class SubCategoryChildModel {
  final String? name;
  final bool? isActive;
  final int? id;

  SubCategoryChildModel({
    this.id,
    this.name,
    this.isActive,
  });

  factory SubCategoryChildModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryChildModel(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
    );
  }
}
