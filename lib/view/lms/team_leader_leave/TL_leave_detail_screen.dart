import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

class TLLeaveDetailsPage extends StatefulWidget {
  static const String id = 'TL_leave_details_page';
  TLLeaveDetailsPage({this.item});
  final Leave item;

  @override
  _TLLeaveDetailsPageState createState() => _TLLeaveDetailsPageState();
}

class _TLLeaveDetailsPageState extends State<TLLeaveDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///App Bar
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          HomeButton(
            color: Colors.black,
          )
        ],
      ),

      ///body
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ///Profile image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserProfileImage(
                              userId: widget.item.userId,
                              height: 60,
                              width: 60),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///User name
                            UserNameText(
                                userId: widget.item.userId, fontSize: 18),
                          ],
                        ),
                      ],
                    ),

                    ///data
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Title
                          Text(
                            this.widget.item.title,
                            style: TextStyle(
                              color: Colors.cyan[800],
                              fontFamily: 'Source Sans Pro',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///Leave type
                              Text(
                                EnumToString.convertToString(widget.item.type)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.type)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ///Icon
                              CircleAvatar(
                                child: CheckType(type: widget.item.type)
                                    .typeIcon(),
                                radius: 15,
                                backgroundColor:
                                    CheckStatus(status: widget.item.status)
                                        .statusColor(),
                                foregroundColor: Colors.white,
                              ),

                              ///Leave Status
                              Text(
                                EnumToString.convertToString(widget.item.status)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.status)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CheckStatus(status: widget.item.status)
                                      .statusColor(),
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          ///Start date
                          DetailRow(
                            keyString: 'Start Date',
                            valueString: widget.item.startDate
                                .toIso8601String()
                                .substring(0, 10),
                          ),
                          SizedBox(height: 5),

                          ///Start day method
                          DetailRow(
                              keyString: 'Start Day Method',
                              valueString: CheckMethod.methodString(
                                  widget.item.startDayMethod)),
                          SizedBox(height: 5),

                          ///End date
                          this.widget.item.endDate != null
                              ? DetailRow(
                                  keyString: 'End Date',
                                  valueString: widget.item.endDate
                                      .toIso8601String()
                                      .substring(0, 10))
                              : SizedBox(),
                          this.widget.item.endDate != null
                              ? SizedBox(height: 5)
                              : SizedBox(),

                          ///End day method
                          this.widget.item.endDate != null
                              ? DetailRow(
                                  keyString: 'End Day Method',
                                  valueString: CheckMethod.methodString(
                                      this.widget.item.endDayMethod))
                              : SizedBox(),
                          this.widget.item.endDate != null
                              ? SizedBox(height: 5)
                              : SizedBox(),

                          ///Leave days
                          DetailRow(
                              keyString: 'Leave Days',
                              valueString: this.widget.item.days.toString()),
                          SizedBox(height: 5),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
