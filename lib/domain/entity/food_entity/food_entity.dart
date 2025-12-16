import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'food_entity.g.dart';

// part 'food_entity.freezed.dart';

// @freezed
// class Products with _$Products {
//   const factory Products(
//       {required String? id,
//       String? name,
//       int? price,
//       String? description,
//       bool? available,
//       required Image? image}) = _Products;
//
//   factory Products.fromJson(Map<String, dynamic> json) =>
//       _$ProductsFromJson(json);
// }

@JsonSerializable()
class FoodEntity {
  FoodEntity(
      {required this.categoryId,
      required this.categoryName,
      required this.products});

  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "category_name")
  final String? categoryName;
  final List<Products>? products;

  factory FoodEntity.fromJson(Map<String, dynamic> json) =>
      _$FoodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FoodEntityToJson(this);
}

@JsonSerializable()
class Products {
  Products(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.available,
      required this.availableTime,
      required this.image});

  final String? id;
  String? name;
  int? price;
  String? description;
  @JsonKey(name: "available_time")
  String? availableTime;
  bool? available;
  final Image? image;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 27)
class Image {
  Image({required this.url, required this.thumb, required this.icon});

  @HiveField(0)
  final String? url;
  @HiveField(1)
  final String? thumb;
  @HiveField(2)
  final String? icon;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
