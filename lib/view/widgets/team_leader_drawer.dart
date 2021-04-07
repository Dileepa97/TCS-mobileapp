import 'package:flutter/material.dart';

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
          onTap: () async {
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //     builder: (BuildContext context) => LeaveRequest()
            //   )
            // );
          },
        ),
        ListTile(
          title: Text("Progress"),
          onTap: () async {
            print("Progress");
          },
        ),
        ListTile(
          title: Text("Products"),
          onTap: () async {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => LeaveRequest()));
          },
        ),
      ],
    ),
  );
}
