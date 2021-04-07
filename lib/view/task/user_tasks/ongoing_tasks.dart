import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/task/task.dart';
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
    List<Task> tasks = await  TeamMemberTaskService.getOngoingTasks("5fa9997450cfb564dc765c5b");
    return tasks;
  }

  Widget cardTop(dynamic index){
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(56, 142, 60, 1),
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
        color: Color.fromRGBO(56, 142, 60, 0.77),
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
//    return Card(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
//      ),
//      color: Colors.greenAccent.shade700,
//      child: Padding(
//        padding: EdgeInsets.all(20),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            Text("Task Name",
//            style: TextStyle(
//                fontSize: 20,
//                color: Colors.white
//              ),
//            ),
//            SizedBox(height: 8),
//            Text("Company name",
//              style: TextStyle(
//                  fontSize: 15,
//                  color: Colors.white
//              ),
//            ),
//            SizedBox(height: 8),
//            Text("Picked by",
//                style: TextStyle(
//                    fontSize: 15,
//                    color: Colors.white
//                )
//            ),
//            SizedBox(height: 8),
//            Text("Stated at",
//                style: TextStyle(
//                    fontSize: 15,
//                    color: Colors.white
//                )
//            )
//          ],
//        ),
//      ),
//    );
  }


  Widget taskListView(index){
    return Container(
          // width: MediaQuery.of(context).size.width * 0.95,
          margin: EdgeInsets.fromLTRB(10, 4, 10, 1),
          child: taskCard(index),
//          child: new Card(
//            color: Colors.greenAccent.shade100,
//            child: ListTile(
//              title: Text(this.ongoingTaskList[index].taskName,
//                style: TextStyle(
//                    color: Colors.green.shade700,
//                    fontSize: 18,
//                    fontWeight: FontWeight.w700
//                ),),
//              leading: CircleAvatar(
//                backgroundColor: Colors.green.shade500,
//                radius: 25,
//                child: CircleAvatar(
//                  backgroundColor: Colors.red,
//                  radius: 20,
//                  child: Text("A"),
//                ),
//              ),
//              trailing: RaisedButton(
//                child: Text("Details",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontWeight: FontWeight.w700,
//                      fontSize: 15
//                  ),
//                ),
//                color: Colors.green.shade500,
//                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (BuildContext context) =>
//                          UserTaskDetails("task01")
//                  ));
//                },
//              ),
//              subtitle: Text("Product : Product ABCD \nPicked by: Chethiya"),
//              isThreeLine: true,
//              contentPadding: EdgeInsets.symmetric(horizontal: 12),
//            ),
//          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if(this.loading){
      return LoadingScreen();
    }
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
      body: ListView.builder(
          itemBuilder: (context,index) {
            return taskCard(index);
          },
          itemCount: this.ongoingTaskList.length,
      ),
    );
  }
}
