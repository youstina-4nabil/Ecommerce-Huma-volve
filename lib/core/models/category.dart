import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String name;

  const Category({this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json['id'], name: json['name'] ?? '');

  @override
  List<Object?> get props => [id, name];
}