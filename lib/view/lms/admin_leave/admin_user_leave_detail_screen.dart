import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/leave_option_builder.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/services/lms/leave_availability_service.dart';

class MoreLeaveDetails extends StatefulWidget {
  static const String id = "more_leave_detail_screen";

  final String userId;

  const MoreLeaveDetails({Key key, this.userId}) : super(key: key);
  @override
  _MoreLeaveDetailsState createState() => _MoreLeaveDetailsState();
}

class _MoreLeaveDetailsState extends State<MoreLeaveDetails> {
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();
  int _year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///App_bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          HomeButton(),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserProfileImage(
                      userId: widget.userId, height: 60, width: 60),
                ),
                UserNameText(userId: widget.userId, fontSize: 18),
              ],
            ),

            Text(
              "Leave Summary",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            Container(
              height: 200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Requested'), Text('00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Accepted'), Text('00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Rejected'), Text('00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Cancelled'), Text('01')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Ongoing'), Text('01')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Ongoing Cancelled'), Text('00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Expired'), Text('00')],
                  )
                ],
              ),
            ),

            Text(
              "Leave Availability Details",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            ///Page builder
            Container(
              height: 350,
              child: FutureBuilder<dynamic>(
                future: _availabilityService.getUserLeaveAvailability(
                    context, this.widget.userId, _year),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  Widget child;
                  if (snapshot.hasData) {
                    List<LeaveOption> list = List<LeaveOption>();

                    if (snapshot.data == 400) {
                      child = Center(child: Text("Bad request"));
                    } else if (snapshot.data == 204) {
                      child = Center(
                          child: Text(
                              "No leave availability data available for this year"));
                    } else if (snapshot.data == 1) {
                      child = Center(child: Text("An unknown error occured"));
                    } else {
                      list = snapshot.data;
                      child = LeaveOptionBuilder(list: list);
                    }
                  } else {
                    child = Center(child: Text("Please wait..."));
                  }

                  return child;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
