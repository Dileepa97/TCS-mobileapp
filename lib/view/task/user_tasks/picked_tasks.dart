import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'file:///G:/level_2_project/Git_Lab/TCS-MobileApp/lib/models/task/team_member_task.dart';
import 'file:///G:/level_2_project/Git_Lab/TCS-MobileApp/lib/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';
import 'package:intl/intl.dart';

class UserPickedTasks extends StatefulWidget {

  final String userId;
  UserPickedTasks(this.userId);

  @override
  _UserPickedTasksState createState() => _UserPickedTasksState();
}

class _UserPickedTasksState extends State<UserPickedTasks> {

  dynamic pickedTaskList;

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
      this.pickedTaskList = tasks;
      this.loading = false;
    });
  }

  Widget cardTop(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.pickedTaskList[index].teamMemberTask.taskName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                SizedBox(height: 8),
                Text(this.pickedTaskList[index].customer.organizationName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardBottom(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.blueAccent.shade100,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text("Picked at "+ DateFormat('yyyy-MM-dd – kk:mm').format(this.pickedTaskList[index].pickedAt),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Source Sans Pro',
                )
            ),
            SizedBox(height: 8),
            Text("Estimated hours "+this.pickedTaskList[index].teamMemberTask.estimatedHours.toString(),
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

  @override
  Widget build(BuildContext context) {
    if(this.loading){
      return LoadingScreen();
    }
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Picked Tasks",
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
      body: (this.pickedTaskList.length == 0 || this.pickedTaskList == 1) ? Container(
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
        itemCount: this.pickedTaskList.length,
      ),
    );
  }

}
