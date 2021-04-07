import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserPartiallyCompletedTasks extends StatefulWidget {

  final String userId;
  UserPartiallyCompletedTasks(this.userId);

  @override
  _UserPartiallyCompletedTasksState createState() => _UserPartiallyCompletedTasksState();
}

class _UserPartiallyCompletedTasksState extends State<UserPartiallyCompletedTasks> {

  List<Task> ongoingTaskList;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      getOngoingTasks().then((value) => {
        setState(() {
          this.ongoingTaskList = value;
          Future.delayed(Duration(milliseconds: 1200),(){
            setState(() {
              this.loading = false;
            });
          });
        })
      });
    }
  }

  Future getOngoingTasks() async{
    List<Task> tasks = await  TeamMemberTaskService.getCompletedTasks("5fa9997450cfb564dc765c5b");
    return tasks;
  }

  Widget cardTop(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(198, 40, 40, 1),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.ongoingTaskList[index].taskName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 8),
            Text("Company name",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
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
        color: Color.fromRGBO(198, 40, 40, 0.77),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:  Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text("Picked by",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                )
            ),
            SizedBox(height: 8),
            Text("Stated at",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                )
            )
          ],
        ),
      ),
    );
  }

  Widget taskCard(dynamic index){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
      appBar: AppBar(
        title: Text("COmpleted Tasks",
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
      body: ListView.builder(
        itemBuilder: (context,index) {
          return taskCard(index);
        },
        itemCount: this.ongoingTaskList.length,
      ),
    );
  }

}
