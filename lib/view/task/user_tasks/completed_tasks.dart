import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserCompletedTasks extends StatefulWidget {

  final String userId;
  UserCompletedTasks(this.userId);

  @override
  _UserCompletedTasksState createState() => _UserCompletedTasksState();
}

class _UserCompletedTasksState extends State<UserCompletedTasks> {


  dynamic completedTaskList;
  bool loading = true;


  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getCompletedTasks();
    }
  }

  Future getCompletedTasks() async{
    dynamic tasks = await  TeamMemberTaskService.getCompletedTasks(widget.userId);
    setState(() {
      this.completedTaskList = tasks;
      this.loading = false;
    });
  }

  Widget cardTop(BuildContext context, dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.completedTaskList[index].teamMemberTask.taskName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                fontFamily: 'Source Sans Pro',
              ),
            ),
            SizedBox(height: 8),
            Text(this.completedTaskList[index].customer.organizationName,
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

  Widget cardBottom(BuildContext context, dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.yellowAccent.shade100,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text("Started at " + DateFormat('yyyy-MM-dd – kk:mm').format(this.completedTaskList[index].startAt),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  fontFamily: 'Source Sans Pro',
                )
            ),
            SizedBox(height: 8),
            Text("Completed at "+DateFormat('yyyy-MM-dd – kk:mm').format(this.completedTaskList[index].endTime),
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

  Widget taskCard(BuildContext context,dynamic index){
    print(context);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: InkWell(
        onTap: (){
          print("Pressed");
        },
        child: Column(
          children: [
            cardTop(context,index),
            cardBottom(context,index)
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
        title: Text("Completed Tasks",
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
      body: (this.completedTaskList.length == 0 || this.completedTaskList == 1) ? Container(
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
          return taskCard(context,index);
        },
        itemCount: this.completedTaskList.length,
      ),
    );
  }
}
