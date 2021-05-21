import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/task/team_tasks/team_tasks_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class ReassignTasksToTeamMembers extends StatefulWidget {
  @override
  _ReassignTasksToTeamMembersState createState() =>
      _ReassignTasksToTeamMembersState();
}

class _ReassignTasksToTeamMembersState
    extends State<ReassignTasksToTeamMembers> {
  dynamic partiallyCompletedTasks;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (this.loading) {
      this.getPartiallyCompletedTasks();
    }
  }

  getPartiallyCompletedTasks() async {
    User user = await UserService.getLoggedInUser();
    dynamic partiallyCompletedTasksOfTeam =
        await TeamTasksService.getReAssignedTasks(user.teamId);
    setState(() {
      this.partiallyCompletedTasks = partiallyCompletedTasksOfTeam;
      this.loading = false;
    });
  }

  void successMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'Successfull !',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                color: Colors.green),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text(
                  'Task accepted as completed',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.grey.shade600),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.green,
                    child: Text(
                      "Okay",
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  void warningMessage(BuildContext context, String teamMemberTaskId) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'Warning !',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                color: Colors.red),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text(
                  "You are going to accept this task as completed",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'This action cannot be undo!',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.blue),
                )),
            FlatButton(
                onPressed: () async{
                  Navigator.pop(context);
                  this.acceptAsCompleted(teamMemberTaskId);
                },
                child: Text(
                  "Accept",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.blue),
                )),
          ],
        );
      },
    );
  }

  void errorMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Failed!',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                color: Colors.red
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text('Cannot complete the task',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.grey.shade600
                  ),
                ),
                SizedBox(height: 20,),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: Colors.redAccent,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                SizedBox(height: 20,),
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                    child: Text("Okay",
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white
                      ),
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  acceptAsCompleted(String teamMemberTaskId) async{

    dynamic response = await TeamTasksService.acceptReAssignedTaskAsCompleted(teamMemberTaskId);
    if(response){
      this.successMessage(context);
    }else{
      this.errorMessage(context);
    }
    this.getPartiallyCompletedTasks();
  }

  Widget taskListView(List<TeamMemberTask> tasks) {
    List<Widget> tasksList = new List<Widget>();
    for (int i = 0; i < tasks.length; i++) {
      tasksList.add(Container(
          // width: MediaQuery.of(context).size.width * 0.95,\
          padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
          child: new Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width * 1,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          this.warningMessage(context, tasks[i].teamMemberTaskId);
                        },
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
                  Text(
                    tasks[i].teamMemberTask.taskName,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Customer : " + tasks[i].customer.organizationName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ended At : " +
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(tasks[i].endTime),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue.shade800,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Picked By : " + tasks[i].teamMember.fullName,
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
          )));
    }

    return new Column(children: tasksList);
  }

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
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
          child: (this.partiallyCompletedTasks == 1 ||
                  this.partiallyCompletedTasks.length == 0)
              ? Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5),
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
              : Column(
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
