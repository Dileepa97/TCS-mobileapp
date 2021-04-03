import 'package:json_annotation/json_annotation.dart';
import 'package:timecapturesystem/models/lms/leave.dart';

part 'leave_cancel_details.g.dart';

@JsonSerializable()
class LeaveCancelDetails {
  String id;

  Leave leave;

  LeaveCancelDetails(this.id, this.leave);

  factory LeaveCancelDetails.fromJson(Map<String, dynamic> data) =>
      _$LeaveCancelDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$LeaveCancelDetailsToJson(this);
}
