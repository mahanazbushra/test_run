import 'package:json_annotation/json_annotation.dart';
part "products_list.g.dart";

@JsonSerializable()
class Product {
  @JsonKey(name: "ID")
  String? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "Description")
  String? description;

  @JsonKey(name: "Category")
  String? category;

  @JsonKey(name: "Image")
  String? image;

  @JsonKey(name: "Price")
  double? price;

  @JsonKey(name: "Yarn Type")
  String? yarn_type;

  @JsonKey(name: "Availability")
  String? availability;

  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.availability,
    this.price,
    this.yarn_type,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);


  Map<String, dynamic> toJson() => _$ProductToJson(this);
}