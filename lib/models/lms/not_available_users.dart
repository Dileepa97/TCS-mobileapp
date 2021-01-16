import 'package:json_annotation/json_annotation.dart';

import 'absent_user_data.dart';

part 'not_available_users.g.dart';

@JsonSerializable()
class NotAvailableUsers {
  DateTime date;
  List<AbsentUser> users;

  NotAvailableUsers(this.date, this.users);

  factory NotAvailableUsers.fromJson(Map<String, dynamic> data) =>
      _$NotAvailableUsersFromJson(data);

  Map<String, dynamic> toJson() => _$NotAvailableUsersToJson(this);
}
