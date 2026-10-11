class Category {
  final int? id; // null يعني "All"
  final String name;

  const Category({this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json['id'], name: json['name'] ?? '');
}