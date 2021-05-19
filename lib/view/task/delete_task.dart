import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/task/task_service.dart';

class DeleteTask extends StatefulWidget {

  static const String id = "delete_tasks";

  final Product product;
  const DeleteTask({this.product});

  @override
  _DeleteTaskState createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {

  bool loading = true;
  dynamic taskList = [];

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getTasks();
    }
  }

  getTasks() async{
    dynamic taskList = await TaskService.getProductTasks(widget.product.id);
    setState(() {
      this.taskList = taskList;
      this.loading = false;
    });
  }


  void warningMessage(BuildContext context, String taskId) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Warning !',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600,
              color: Colors.red
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text("Do you really want to delete?",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey.shade600
                  ),
                ),
                SizedBox(height: 10,),
                Text('This action cannot be undone!',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey.shade600
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.blue
              ),
            )
            ),

            FlatButton(onPressed: ()async{
              Navigator.pop(context);
              this.loading = true;
              await TaskService.deleteProductTask(taskId);
              getTasks() ;

            }, child: Text("Delete",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.blue
              ),
            )
            ),
          ],
        );
      },
    );
  }


  Widget taskListView(dynamic tasks){
    List<Widget> tasksList = new List<Widget>();

    for(int i = 0; i<tasks.length; i++){
      tasksList.add(Container(
        // width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
        child: new Container(
          height: MediaQuery.of(context).size.height / 5.5,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.taskList[i].taskName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade800,
                    fontFamily: 'Arial',
                  ),
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Estimated Hours : "+this.taskList[i].estimatedHours.toString() + " Hrs",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade800,
                            fontFamily: 'Arial',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Created At : "+DateFormat('yyyy-MM-dd – kk:mm').format(this.taskList[i].createdAt),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade800,
                            fontFamily: 'Arial',
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      child: Text("Delete",style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Arial',
                      ),),
                        color: Colors.red,
                        onPressed: (){
                          this.warningMessage(context, this.taskList[i].taskId);
                        }
                        )
                  ],
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
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Delete Tasks",
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
          child: (this.taskList == 1) ? Container(
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
              SizedBox(height: 15,),
              taskListView(this.taskList)
            ],
          )
      ),
    );
  }
}
