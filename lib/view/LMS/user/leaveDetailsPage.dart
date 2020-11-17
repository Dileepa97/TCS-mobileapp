import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/leave/LeaveResponse.dart';

class LeaveDetailsPage extends StatelessWidget {
  LeaveDetailsPage({this.item});
  final LeaveResponse item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.userId),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(5.0),
            child: Card(
              shadowColor: Colors.black54,
              color: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage('images/user.png'),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: VerticalDivider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            detailsRow('Leave Title', this.item.leaveTitle),
                            SizedBox(height: 5),
                            detailsRow(
                                'Leave Type',
                                EnumToString.convertToString(
                                    this.item.leaveType)),
                            SizedBox(height: 5),
                            detailsRow(
                                'Leave Status',
                                EnumToString.convertToString(
                                    this.item.leaveStatus)),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            detailsRow(
                                'Request Date', stringDate(this.item.reqDate)),
                            SizedBox(height: 5),
                            detailsRow('Start Date',
                                stringDate(this.item.leaveStartDate)),
                            SizedBox(height: 5),
                            detailsRow(
                                'End Date', stringDate(this.item.leaveEndDate)),
                            SizedBox(height: 5),
                            detailsRow(
                                'Leave Days', this.item.leaveCount.toString()),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            detailsRow('Description', ''),
                            Text(
                              this.item.leaveDescription,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RoundedButton(
                                  color: Colors.lightGreen,
                                  title: 'Accept',
                                  minWidth: 100.0,
                                ),
                                RoundedButton(
                                  color: Colors.red[300],
                                  title: 'Reject',
                                  minWidth: 100,
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }

  String stringDate(DateTime date) {
    return date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }

  Row detailsRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$key : ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
