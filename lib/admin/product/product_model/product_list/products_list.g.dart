// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['ID'] as String?,
      name: json['Name'] as String?,
      description: json['Description'] as String?,
      category: json['Category'] as String?,
      image: json['Image'] as String?,
      availability: json['Availability'] as String?,
      price: (json['Price'] as num?)?.toDouble(),
      yarn_type: json['Yarn Type'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'Description': instance.description,
      'Category': instance.category,
      'Image': instance.image,
      'Price': instance.price,
      'Yarn Type': instance.yarn_type,
      'Availability': instance.availability,
    };
