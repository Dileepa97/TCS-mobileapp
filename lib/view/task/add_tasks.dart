import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/services/task/task_service.dart';

class AddTask extends StatefulWidget {
  static const String id = "view_tasks";

  final Product product;
  const AddTask({this.product});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String taskName;
  double estimatedHours;

  void successMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'Task Created Succsfully !',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
                color: Colors.green),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text(
                  'Added task can be seen at all tasks.',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.grey.shade600),
                ),
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
                    },
                    color: Colors.green,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Add task",
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.all(5),
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
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Submit',
                  minWidth: 200.0,
                  onPressed: () async {
                    Task task = new Task(
                        productId: widget.product.id,
                        taskName: this.taskName,
                        estimatedHours: this.estimatedHours);
                    await TaskService.addProductTask(task);
                    this.estimatedHours = 0.0;
                    this.taskName = '';
                    this.successMessage(context);
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
