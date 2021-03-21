import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/widgets/view_task_drawer.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {


  void successMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Task Created Succsfully !',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text('Added task can be seen at all tasks.',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.grey.shade600
                  ),
                ),
              ],
            ),
          ),
          actions: [
//            new FlatButton(
//              child: new Text('Ok'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),

            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Add another task",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.lightBlueAccent
              ),
            )
            ),
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.lightBlueAccent
              ),
            )
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task",
            style: TextStyle(
                color: Colors.black87
            )),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: viewTaskDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Task name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter task name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Estimated hours',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter task name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 100,),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Add task",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17
                    ),
                  ),
                    onPressed: (){
                      this.successMessage(context);
                    }
                    ),
                SizedBox(height: 20,),
                RaisedButton(
                    child: Text("Go back",
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    onPressed: (){
                      this.successMessage(context);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
