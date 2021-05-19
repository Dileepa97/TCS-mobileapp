import 'package:flutter/material.dart';

class DeleteTask extends StatefulWidget {
  @override
  _DeleteTaskState createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {



  List<String> taskList = ['Task 1','Task 2','Task 3','Task 4','Task 5','Task 6'];

  void warningMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Please confirm to delete task',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text("Warning!",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.red
                  ),
                ),
                SizedBox(height: 10,),
                Text('This action cannot be un done!',
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

            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Confirm",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.blue
              ),
            )
            ),
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
            )
          ],
        );
      },
    );
  }

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
                backgroundColor: Colors.yellowAccent,
                radius: 20,
                child: Text("A"),
              ),
            ),
            trailing: FlatButton(
              color: Colors.red,
                onPressed: (){
                this.warningMessage(context);
              }, child: Text("Delete",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white
                ),
              )
            ),
            subtitle: Text("tap to more information"),
            onTap: () {
//              Navigator.push(context, MaterialPageRoute(
//                  builder: (BuildContext context)=>TaskDetail("dwwd1019")
//              ));
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
        title: Text("Delete Tasks",
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
