import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/task/task_service.dart';
import 'package:timecapturesystem/view/task/update_task.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UpdateTaskListView extends StatefulWidget {
  static const String id = "view_tasks";

  final Product product;
  const UpdateTaskListView({this.product});

  @override
  _UpdateTaskListViewState createState() => _UpdateTaskListViewState();
}

class _UpdateTaskListViewState extends State<UpdateTaskListView> {
  bool loading = true;
  dynamic taskList;

  @override
  void initState() {
    super.initState();
    if (this.loading) {
      this.getTasks();
    }
  }

  getTasks() async {
    dynamic taskList = await TaskService.getProductTasks(widget.product.id);

    setState(() {
      this.taskList = taskList;
      this.loading = false;
    });
  }

  Widget taskListView(dynamic tasks) {
    List<Widget> tasksList = new List<Widget>();

    for (int i = 0; i < tasks.length; i++) {
      tasksList.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UpdateTask(
                        task: this.taskList[i],
                        product: widget.product,
                      )));
        },
        child: Container(
            // width: MediaQuery.of(context).size.width * 0.95,\
            padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
            child: new Container(
              height: MediaQuery.of(context).size.height / 6.5,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.taskList[i].taskName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue.shade800,
                        fontFamily: 'Arial',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Estimated Hours : " +
                          this.taskList[i].estimatedHours.toString() +
                          " Hrs",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue.shade800,
                        fontFamily: 'Arial',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Created At : " +
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(this.taskList[i].createdAt),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue.shade800,
                        fontFamily: 'Arial',
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            )),
      ));
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
        title: Text("Update Tasks",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Arial',
            )),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      // drawer: viewTaskDrawer(context),
      body: SingleChildScrollView(
          // ignore: unrelated_type_equality_checks
          child: (this.taskList == 1)
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
                    taskListView(this.taskList)
                  ],
                )),
    );
  }
}
