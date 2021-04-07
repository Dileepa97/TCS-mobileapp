import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/LMS/user_leave/leave_request_main_screen.dart';
import 'package:timecapturesystem/view/task/add_tasks.dart';
import 'package:timecapturesystem/view/task/task_dashboard.dart';

Widget viewTaskDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Text("Select"),
        ),
        ListTile(
          title: Text("Dashboard"),
          onTap: () async{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => TaskDashboard("110")
            )
            );
          },
        ),
        ListTile(
          title: Text("Add Tasks"),
          onTap: () async{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => AddTask()
              )
            );
          },
        ),
        ListTile(
          title: Text("Delete Tasks"),
          onTap: () async{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => LeaveRequest()
            )
            );
          },
        ),
        ListTile(
          title: Text("Update Tasks"),
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