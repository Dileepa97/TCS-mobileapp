import 'package:json_annotation/json_annotation.dart';

part 'user_history.g.dart';

@JsonSerializable()
class UserHistory {
  String id;

  String username;

  String fullName;

  String telephoneNumber;

  String email;

  String title;

  bool probationary;

  UserHistory(this.id, this.username, this.fullName, this.telephoneNumber,
      this.email, this.title, this.probationary);

  factory UserHistory.fromJson(Map<String, dynamic> data) =>
      _$UserHistoryFromJson(data);

  Map<String, dynamic> toJson() => _$UserHistoryToJson(this);

  @override
  String toString() {
    return 'UserHistory{id: $id, username: $username, fullName: $fullName, telephoneNumber: $telephoneNumber, email: $email, title: $title, probationary: $probationary}';
  }
}
