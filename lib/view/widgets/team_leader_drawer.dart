import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/LMS/user_leave/leave_request_main_screen.dart';

Widget teamLeaderDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Text("Select"),
        ),
        ListTile(
          title: Text("Leave"),
          onTap: () async{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => LeaveRequest()
              )
            );
          },
        ),
        ListTile(
          title: Text("Progress"),
          onTap: () async{
            print("Progress");
          },
        ),
        ListTile(
          title: Text("Products"),
          onTap: () async{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => LeaveRequest()
            )
            );
          },
        ),
      ],
    ),
  );
}