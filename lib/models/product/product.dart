import 'package:json_annotation/json_annotation.dart';
import 'package:timecapturesystem/models/task/task.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;

  String productName;

  String productDescription;

  List<String> customerIdList;

  List<Task> tasks;

  int taskCount;

  Product(
      this.id, this.productName, this.productDescription, this.customerIdList, this.taskCount);

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
