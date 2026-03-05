class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }
}

class SA2Model {
  final int id;
  final String name;

  SA2Model({required this.id, required this.name});

  factory SA2Model.fromJson(Map<String, dynamic> json) {
    return SA2Model(id: json['id'], name: json['name']);
  }
}
