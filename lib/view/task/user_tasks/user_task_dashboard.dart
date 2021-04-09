import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/task/team_member_task/team_member_task_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/user_tasks/completed_tasks.dart';
import 'package:timecapturesystem/view/task/user_tasks/ongoing_tasks.dart';
import 'package:timecapturesystem/view/task/user_tasks/partially_completd_tasks.dart';
import 'package:timecapturesystem/view/task/user_tasks/picked_tasks.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class UserTaskDashboard extends StatefulWidget {

  final String userId;
  UserTaskDashboard(this.userId);

  @override
  _UserTaskDashboardState createState() => _UserTaskDashboardState();
}

class _UserTaskDashboardState extends State<UserTaskDashboard> {

  User user;
  bool _userAvailable = false;

  TeamMemberTaskService teamMemberTaskService = new TeamMemberTaskService();

  void getUser() async {
    user = await TokenStorageService.userDataOrEmpty;
    print(user);
    setState(() {
      _userAvailable = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight -24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Tasks",
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
      body: Center(
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          shrinkWrap: true,
          childAspectRatio: (itemWidth / (itemHeight /4.2)),
          physics: ScrollPhysics(),
          children: [

            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade700
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 20,),
                        Text("Picked Tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=> UserPickedTasks(user.id)
                     )
                    );
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (BuildContext context)=>ViewTasks("110")
//                    )
//                    );
                  },
                ),
              ),
            ),

            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade600
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 20,),
                        Text("Ongoing Tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=> UserOngoingTasks(user.id)
                    )
                    );
                  },
                ),
              ),
            ),

            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow.shade700
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.done_all,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 20,),
                        Text("Completed Tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>UserCompletedTasks(user.id)
                    )
                    );
                  },
                ),
              ),
            ),

            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.shade700
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 20,),
                        Text("Partially Completed Tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>UserPartiallyCompletedTasks(user.id)
                    )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
