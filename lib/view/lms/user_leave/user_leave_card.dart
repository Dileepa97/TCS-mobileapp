import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave.dart';

import '../check_leaves.dart';

class UserLeaveCard extends StatefulWidget {
  UserLeaveCard({this.item});
  final Leave item;

  @override
  _UserLeaveCardState createState() => _UserLeaveCardState();
}

class _UserLeaveCardState extends State<UserLeaveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 90,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: CheckType(type: widget.item.type).typeIcon(),
            radius: 25,
            backgroundColor:
                CheckStatus(status: widget.item.status).statusColor(),
            foregroundColor: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.widget.item.title,
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontFamily: 'Source Sans Pro',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                        Text(
                          EnumToString.convertToString(widget.item.type)
                                  .substring(0, 1) +
                              EnumToString.convertToString(widget.item.type)
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', ' '),
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.purple[900],
                            fontFamily: 'Source Sans Pro',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          EnumToString.convertToString(widget.item.status)
                                  .substring(0, 1) +
                              EnumToString.convertToString(widget.item.status)
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', ' '),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CheckStatus(status: widget.item.status)
                                .statusColor(),
                          ),
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
