import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  String id;

  String organizationID;

  String organizationName;

  String email;

  List<String> productIdList;

  Customer(this.id, this.organizationID, this.organizationName, this.email,
      this.productIdList);

  factory Customer.fromJson(Map<String, dynamic> data) =>
      _$CustomerFromJson(data);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
