// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['id'] as String,
    json['organizationID'] as String,
    json['organizationName'] as String,
    json['email'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'organizationID': instance.organizationID,
      'organizationName': instance.organizationName,
      'email': instance.email,
    };
