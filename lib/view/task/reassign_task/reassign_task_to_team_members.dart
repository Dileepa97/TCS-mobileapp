import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/task/team_tasks/team_tasks_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class ReassignTasksToTeamMembers extends StatefulWidget {
  @override
  _ReassignTasksToTeamMembersState createState() => _ReassignTasksToTeamMembersState();
}

class _ReassignTasksToTeamMembersState extends State<ReassignTasksToTeamMembers> {

  dynamic partiallyCompletedTasks;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getPartiallyCompletedTasks();
    }
  }


  getPartiallyCompletedTasks() async{
    User user = await UserService.getLoggedInUser();
    dynamic partiallyCompletedTasksOfTeam = await TeamTasksService.getReAssignedTasks(user.teamId);
    setState(() {
      this.partiallyCompletedTasks = partiallyCompletedTasksOfTeam;
      this.loading = false;
    });
  }

  Widget taskListView(List<TeamMemberTask> tasks) {
    List<Widget> tasksList = new List<Widget>();
    for (int i = 0; i < tasks.length; i++) {
      tasksList.add(Container(
        // width: MediaQuery.of(context).size.width * 0.95,\
          padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
          child: new Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment : MainAxisAlignment.end,
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.pinkAccent,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )
                    ],
                  ),

                  Text(tasks[i].teamMemberTask.taskName,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Customer : " +
                      tasks[i].customer.organizationName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Ended At : " +
                      DateFormat('yyyy-MM-dd – kk:mm').format(
                          tasks[i].endTime),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Picked By : " + tasks[i].teamMember.fullName,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )
      ));
    }

    return new Column(children: tasksList);

  }


  @override
  Widget build(BuildContext context) {

    if(this.loading){
      return LoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Team Partial Tasks",
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
      body: SingleChildScrollView(
          child: (this.partiallyCompletedTasks == 1 || this.partiallyCompletedTasks.length == 0) ? Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
              child: Center(
                child: Text("No Tasks found",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    fontFamily: 'Arial',
                  ),),
              )
          ) : Column(
            children: [
              SizedBox(
                height: 15,
              ),
              taskListView(this.partiallyCompletedTasks)
            ],
          )),
    );
  }
}
