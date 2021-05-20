import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/services/task/task_service.dart';
import 'package:timecapturesystem/view/task/update_task_list_view.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UpdateTask extends StatefulWidget {
  static const String id = "update_task";

  final Task task;
  final Product product;
  const UpdateTask({this.task, this.product});

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  String taskName;
  double estimatedHours;
  bool loading = true;
  bool taskUpdate = false;
  String displayTaskName;
  double displayEstimatedHours;

  @override
  void initState() {
    super.initState();
    if (this.loading) {
      Future.delayed(Duration(milliseconds: 1200), () {
        setState(() {
          this.displayTaskName = widget.task.taskName;
          this.displayEstimatedHours = widget.task.estimatedHours;
          this.loading = false;
        });
      });
    }
  }

  void successMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'Task Updated succesfully !',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UpdateTaskListView(
                                    product: widget.product,
                                  )));
                    },
                    color: Colors.redAccent,
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

  void warningMessage(BuildContext context) {
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
                  'Do you really want to update the task?',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
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
                  "No",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.lightBlueAccent),
                )),
            FlatButton(
                onPressed: () async {
                  if (this.taskName != null && this.estimatedHours != null) {
                    Task task = new Task(
                        productId: widget.task.productId,
                        createdAt: widget.task.createdAt,
                        taskStatus: widget.task.taskStatus,
                        taskId: widget.task.taskId,
                        taskName: this.taskName,
                        estimatedHours: this.estimatedHours);
                    this.loading = true;
                    await TaskService.updateTask(task).then((value) => {});
                  }
                  if (this.taskName != null && this.estimatedHours == null) {
                    Task task = new Task(
                        productId: widget.task.productId,
                        createdAt: widget.task.createdAt,
                        taskStatus: widget.task.taskStatus,
                        taskId: widget.task.taskId,
                        taskName: this.taskName,
                        estimatedHours: widget.task.estimatedHours);
                    this.loading = true;
                    await TaskService.updateTask(task).then((value) => {});
                  }
                  if (this.taskName == null && this.estimatedHours != null) {
                    Task task = new Task(
                        productId: widget.task.productId,
                        createdAt: widget.task.createdAt,
                        taskStatus: widget.task.taskStatus,
                        taskId: widget.task.taskId,
                        taskName: widget.task.taskName,
                        estimatedHours: this.estimatedHours);
                    this.loading = true;
                    await TaskService.updateTask(task).then((value) => {});
                  }

                  Navigator.pop(context);

                  this.successMessage(context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.lightBlueAccent),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.loading) {
      return LoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Add task", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.8,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Enter Task Details',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    color: Colors.lightBlue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DividerBox(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    'Fill feilds that you only want to update. If you don\'t want to upadte any feild keep it blank or empty.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.blueGrey,
                      fontSize: 15,
                    ),
                  ),
                ),
                DividerBox(),
                InputContainer(
                  child: InputTextField(
                    labelText: 'Task name',
                    onChanged: (text) {
                      setState(() {
                        this.taskName = text;
                      });
                    },
                  ),
                ),
                Text(
                  "Previous : " + widget.task.taskName,
                  style: TextStyle(
                    fontFamily: 'Arial',
                  ),
                ),
                InputContainer(
                  child: InputTextField(
                    maxLines: null,
                    labelText: 'Estimated hours',
                    onChanged: (text) {
                      setState(() {
                        this.estimatedHours = double.parse(text);
                      });
                    },
                  ),
                ),
                Text(
                  "Previous : " +
                      widget.task.estimatedHours.toString() +
                      " Hrs",
                  style: TextStyle(
                    fontFamily: 'Arial',
                  ),
                ),
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Submit',
                  minWidth: 200.0,
                  onPressed: () async {
                    this.warningMessage(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
