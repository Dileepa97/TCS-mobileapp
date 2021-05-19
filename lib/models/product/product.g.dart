// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'] as String,
    json['productName'] as String,
    json['productDescription'] as String,
    (json['customerIdList'] as List)?.map((e) => e as String)?.toList(),
    json['taskCount'] as int
  )..tasks = (json['tasks'] as List)
      ?.map((e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'customerIdList': instance.customerIdList,
      'tasks': instance.tasks,
    };
