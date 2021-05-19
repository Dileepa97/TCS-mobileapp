import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserOngoingTasks extends StatefulWidget {

  final String userId;
  UserOngoingTasks(this.userId);

  @override
  _UserOngoingTasksState createState() => _UserOngoingTasksState();
}


class _UserOngoingTasksState extends State<UserOngoingTasks> {

  dynamic ongoingTaskList;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getOngoingTasks();
    }
  }

  Future getOngoingTasks() async{
    dynamic tasks = await  TeamMemberTaskService.getOngoingTasks(widget.userId);
    setState(() {
      this.ongoingTaskList = tasks;
      this.loading = false;
    });
  }

  Widget cardTop(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.ongoingTaskList[index].teamMemberTask.taskName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                fontFamily: 'Source Sans Pro',
              ),
            ),
            SizedBox(height: 8),
            Text(this.ongoingTaskList[index].customer.organizationName,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                fontFamily: 'Source Sans Pro',
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget cardBottom(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade100,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text("Picked at "+DateFormat('yyyy-MM-dd – kk:mm').format(this.ongoingTaskList[index].pickedAt),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  fontFamily: 'Source Sans Pro',
                )
            ),
            SizedBox(height: 8),
            Text("Estimated time "+ this.ongoingTaskList[index].teamMemberTask.estimatedHours.toString() + " Hrs",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  fontFamily: 'Source Sans Pro',
                )
            )
          ],
        ),
      ),
    );
  }

  Widget taskCard(dynamic index){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: (){
          print("Pressed");
        },
        child: Column(
          children: [
            cardTop(index),
            cardBottom(index)
          ],
        ),
      ),
    );
  }


  Widget taskListView(index){
    return Container(
          // width: MediaQuery.of(context).size.width * 0.95,
          margin: EdgeInsets.fromLTRB(10, 4, 10, 1),
          child: taskCard(index),
        );
  }

  @override
  Widget build(BuildContext context) {
    if(this.loading){
      return LoadingScreen();
    }
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Ongoing Tasks",
            style: TextStyle(
                color: Colors.white,
              fontFamily: 'Source Sans Pro',
            )),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: SideDrawer(),
      body: (this.ongoingTaskList.length == 0 || this.ongoingTaskList == 1) ? Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 17),
          child: Center(
            child: Text("No Tasks found",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),),
          )
      ) : ListView.builder(
          itemBuilder: (context,index) {
            return taskCard(index);
          },
          itemCount: this.ongoingTaskList.length,
      ),
    );
  }
}
