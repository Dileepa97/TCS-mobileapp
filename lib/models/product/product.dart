import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;

  String productName;

  String productDescription;

  List<String> customerIdList;

  // List<Task> tasks;

  Product(
      this.id, this.productName, this.productDescription, this.customerIdList);

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
