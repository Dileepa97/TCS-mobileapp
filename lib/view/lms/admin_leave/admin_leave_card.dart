import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import '../check_leaves.dart';

class AdminLeaveCard extends StatefulWidget {
  final Leave item;
  AdminLeaveCard({this.item});

  @override
  _AdminLeaveCardState createState() => _AdminLeaveCardState();
}

class _AdminLeaveCardState extends State<AdminLeaveCard> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 100,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          ///profile image
          UserProfileImage(userId: widget.item.userId, height: 60, width: 60),

          ///details
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///user name
                  UserNameText(userId: widget.item.userId, fontSize: 15),

                  ///start date
                  Text(
                    'Start date : ' +
                        widget.item.startDate
                            .toIso8601String()
                            .substring(0, 10),
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///leave type
                        Text(
                          EnumToString.convertToString(widget.item.type)
                                  .substring(0, 1) +
                              EnumToString.convertToString(widget.item.type)
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', '\n'),
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontFamily: 'Source Sans Pro',
                            fontSize: 15,
                          ),
                        ),

                        ///leave status
                        Text(
                          EnumToString.convertToString(widget.item.status)
                                  .substring(0, 1) +
                              EnumToString.convertToString(widget.item.status)
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', '\n'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CheckStatus(status: widget.item.status)
                                .statusColor(),
                          ),
                        ),

                        ///icon
                        CircleAvatar(
                          child: CheckType(type: widget.item.type).typeIcon(),
                          radius: 15,
                          backgroundColor:
                              CheckStatus(status: widget.item.status)
                                  .statusColor(),
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
