import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/models/lms/leave.dart';

import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_page.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_user_leave_detail_screen.dart';

class LeaveCancelCard extends StatefulWidget {
  final Leave data;

  const LeaveCancelCard({Key key, this.data}) : super(key: key);

  @override
  _LeaveCancelCardState createState() => _LeaveCancelCardState();
}

class _LeaveCancelCardState extends State<LeaveCancelCard> {
  ShowAlertDialog _dialog = ShowAlertDialog();
  LeaveService _leaveService = LeaveService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ///Row1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///profile image
              UserProfileImage(
                  userId: widget.data.userId, height: 35, width: 35),

              ///user name
              UserNameText(
                userId: widget.data.userId,
                fontSize: 16,
              ),

              ///button to leave detail page
              GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
                  child: Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLeaveDetailsPage(
                        item: widget.data,
                        isMoreUserLeave: true,
                        isOngoing: true,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          DividerBox(),

          ///Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //start date
              Text(
                'Start date : ' +
                    widget.data.startDate.toIso8601String().substring(0, 10),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 15,
                ),
              ),

              ///end date
              widget.data.endDate != null
                  ? Text(
                      'End date : ' +
                          widget.data.endDate
                              .toIso8601String()
                              .substring(0, 10),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 15,
                      ),
                    )
                  : SizedBox(),
            ],
          ),

          ///Day method Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //start day method
              Text(
                EnumToString.convertToString(widget.data.startDayMethod)
                        .substring(0, 1) +
                    EnumToString.convertToString(
                            this.widget.data.startDayMethod)
                        .substring(1)
                        .toLowerCase()
                        .replaceAll('_', ' '),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 15,
                ),
              ),

              ///end day method
              widget.data.endDate != null
                  ? Text(
                      EnumToString.convertToString(widget.data.endDayMethod)
                              .substring(0, 1) +
                          EnumToString.convertToString(
                                  this.widget.data.endDayMethod)
                              .substring(1)
                              .toLowerCase()
                              .replaceAll('_', ' '),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 15,
                      ),
                    )
                  : SizedBox(),
            ],
          ),

          ///leave day count
          SizedBox(
            height: 4,
          ),
          Text(
            'Leave days : ' + widget.data.days.toString(),
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Source Sans Pro',
              fontSize: 16,
            ),
          ),
          DividerBox(),

          ///user leave detail button
          GestureDetector(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
              ),
              child: Text(
                'User Leave Details',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 16,
                ),
              ),
            ),

            ///on tap function
            onTap: () {
              // Navigator.pushNamed(
              //     context, MoreLeaveDetails.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoreLeaveDetails(
                    userId: this.widget.data.userId,
                  ),
                ),
              );
            },
          ),
          DividerBox(),

          ///set taken days
          GestureDetector(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Text(
                'Set taken days',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 15,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
              ),
            ),

            ///on pressed button
            onTap: () {
              String days;

              this._dialog.showConfirmationDialog(
                    title: 'Confirm',
                    context: context,

                    ///dialog body
                    children: [
                      Text(
                          'Enter taken days and press \'yes\' to confirm. (cannot change after confirm)'),
                      TextField(
                          decoration: InputDecoration(hintText: 'Taken days'),
                          maxLines: null,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              days = value;
                            });
                          })
                    ],

                    ///on pressed yes
                    onPressedYes: () {
                      //if taken days field is empty
                      if (days == null || days.trim() == '') {
                        _dialog.showAlertDialog(
                          title: 'Something Missing !',
                          body: 'Enter taken days',
                          color: Colors.redAccent,
                          context: context,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      ///if input is not valid
                      else if (double.tryParse(days) == null) {
                        _dialog.showAlertDialog(
                          title: 'Invalid Input !',
                          body: 'Please enter valid number',
                          color: Colors.redAccent,
                          context: context,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      ///if entered day count is greater than leave days
                      else if (double.tryParse(days) > widget.data.days) {
                        _dialog.showAlertDialog(
                          title: 'Invalid input !',
                          body:
                              'Entered number of taken days are greater than the number of leave days',
                          color: Colors.redAccent,
                          context: context,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      ///if entered day count is lesser than 0
                      else if (double.tryParse(days).isNegative) {
                        _dialog.showAlertDialog(
                          title: 'Invalid input !',
                          body:
                              'Entered number of taken days cannot be negative',
                          color: Colors.redAccent,
                          context: context,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      ///if entered number of taken days is acceptable
                      else {
                        _dialog.showAlertDialog(
                          title: 'Confirm',
                          body: 'Confirm taken days as $days',
                          color: Colors.blueAccent,
                          context: context,
                          onPressed: () async {
                            int code = await _leaveService.setTakenDays(
                                widget.data.id, days);

                            ///if changed successfully
                            if (code == 200) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              this._dialog.showAlertDialog(
                                    context: context,
                                    title: 'Done',
                                    body:
                                        'Leave taken days changed successfully.',
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                            }

                            ///if some error occur
                            else {
                              Navigator.pop(context);
                              this._dialog.showAlertDialog(
                                    context: context,
                                    title: 'Error occurred',
                                    body:
                                        'Cannot complete this task. \nTry again later',
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                            }
                          },
                        );
                      }
                    },

                    ///on pressed no
                    onPressedNo: () {
                      Navigator.pop(context);
                    },
                  );
            },
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
