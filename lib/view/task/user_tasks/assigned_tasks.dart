import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file:///G:/level_2_project/Git_Lab/TCS-MobileApp/lib/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserReAssignedTasks extends StatefulWidget {

  final String userId;
  UserReAssignedTasks(this.userId);

  @override
  _UserReAssignedTasksState createState() => _UserReAssignedTasksState();
}

class _UserReAssignedTasksState extends State<UserReAssignedTasks> {

  dynamic reAssignedTaskList;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      getReAssignedTasks();
    }
  }

  Future getReAssignedTasks() async{
    dynamic tasks = await  TeamMemberTaskService.getReAssignedTasks(widget.userId);
    setState(() {
      this.reAssignedTaskList = tasks;
      this.loading = false;
    });
  }

  Widget cardTop(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.reAssignedTaskList[index].teamMemberTask.taskName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 8),
            Text(this.reAssignedTaskList[index].customer.organizationName,
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

  Widget cardBottom(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.shade100,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text("Last Picked By : "+ this.reAssignedTaskList[index].teamMember.fullName,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                )
            ),
            SizedBox(height: 8),
            Text("Picked at : "+ DateFormat('yyyy-MM-dd – kk:mm').format(this.reAssignedTaskList[index].pickedAt),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                )
            ),
            SizedBox(height: 8),
            Text("Estimated hours : "+this.reAssignedTaskList[index].teamMemberTask.estimatedHours.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Arial',
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
        title: Text("Re-Assigned Tasks",
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
      body: (this.reAssignedTaskList.length == 0 || this.reAssignedTaskList == 1) ? Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 17),
          child: Center(
            child: Text("No Tasks found",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Arial',
              ),),
          )
      ) : ListView.builder(
        itemBuilder: (context,index) {
          return taskCard(index);
        },
        itemCount: this.reAssignedTaskList.length,
      ),
    );
  }
}
