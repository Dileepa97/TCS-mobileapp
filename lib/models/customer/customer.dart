import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  String id;

  String organizationID;

  String organizationName;

  String email;

  Customer(this.id, this.organizationID, this.organizationName, this.email);

  factory Customer.fromJson(Map<String, dynamic> data) =>
      _$CustomerFromJson(data);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
