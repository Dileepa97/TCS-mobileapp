import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';

class UserTaskDetails extends StatelessWidget {

  final String taskId;
  UserTaskDetails(this.taskId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Tasks",
            style: TextStyle(
                color: Colors.black87
            )),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: SideDrawer(),
    );
  }
}
