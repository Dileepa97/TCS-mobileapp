import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserPartiallyCompletedTasks extends StatefulWidget {
  final String userId;

  UserPartiallyCompletedTasks(this.userId);

  @override
  _UserPartiallyCompletedTasksState createState() =>
      _UserPartiallyCompletedTasksState();
}

class _UserPartiallyCompletedTasksState
    extends State<UserPartiallyCompletedTasks> {
  List<TeamMemberTask> partiallyCompletedTaskList;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (this.loading) {
      this.getPartiallyCompletedTasks();
    }
  }

  Future getPartiallyCompletedTasks() async {
    dynamic tasks =
        await TeamMemberTaskService.getPartiallyCompletedTasks(widget.userId);
    setState(() {
      this.partiallyCompletedTaskList = tasks;
      this.loading = false;
    });
  }

  Widget cardTop(dynamic index) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.partiallyCompletedTaskList[index].teamMemberTask.taskName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 8),
            Text(
              this.partiallyCompletedTaskList[index].customer.organizationName,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget cardBottom(dynamic index) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.redAccent.shade100,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
                "Started at  " +
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(this.partiallyCompletedTaskList[index].startAt),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                )),
            SizedBox(height: 8),
            Text(
                "Ended at   " +
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(this.partiallyCompletedTaskList[index].endTime),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                ))
          ],
        ),
      ),
    );
  }

  Widget taskCard(dynamic index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: () {
          print("Pressed");
        },
        child: Column(
          children: [cardTop(index), cardBottom(index)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
      return LoadingScreen();
    }
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Partially Completed Tasks",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Arial',
            )),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: SideDrawer(),
      // ignore: unrelated_type_equality_checks
      body: (this.partiallyCompletedTaskList.length == 0 ||
              this.partiallyCompletedTaskList == 1)
          ? Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 17),
              child: Center(
                child: Text(
                  "No Tasks found",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Arial',
                  ),
                ),
              ))
          : ListView.builder(
              itemBuilder: (context, index) {
                return taskCard(index);
              },
              itemCount: this.partiallyCompletedTaskList.length,
            ),
    );
  }
}
