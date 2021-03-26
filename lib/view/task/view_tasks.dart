import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/task/task_detail.dart';

// ignore: must_be_immutable
class ViewTasks extends StatefulWidget {
  String taskId;
  ViewTasks(String taskId){
    this.taskId = taskId;
  }
  @override
  _ViewTasksState createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {

  List<String> taskList = ['Task 1','Task 2','Task 3','Task 4','Task 5','Task 6'];

  Widget searchBar(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search",
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print("Pressed");
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )
        )
      ),
    );
  }

  Widget taskListView(List<String> tasks){
    List<Widget> tasksList = new List<Widget>();

    for(int i = 0; i<tasks.length; i++){
      tasksList.add(Container(
        // width: MediaQuery.of(context).size.width * 0.95,
        child: new Card(
          child: ListTile(
            title: Text(tasks[i]),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 25,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
                child: Text("A"),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert_rounded),
            ),
            subtitle: Text("tap to more information"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context)=>TaskDetail("dwwd1019")
              ));
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ));
    }

    return new Column(children: tasksList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tasks",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600
            )),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      // drawer: viewTaskDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Center(child: searchBar()),
            SizedBox(height: 25,),
            taskListView(this.taskList)
          ],
        )
      ),
    );
  }
}
