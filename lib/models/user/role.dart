import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable()
class Role {
  String id, name;

  Role(this.id, this.name);

  factory Role.fromJson(Map<String, dynamic> data) => _$RoleFromJson(data);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

enum ERole { ROLE_TEAM_MEMBER, ROLE_TEAM_LEADER, ROLE_ADMIN, ROLE_SUPER_ADMIN }
