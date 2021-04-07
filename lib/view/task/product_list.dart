import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/convert.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/task_dashboard.dart';
import 'package:timecapturesystem/view/widgets/team_leader_drawer.dart';

class TaskPanel extends StatelessWidget {
  Widget productCard(String product, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TaskDashboard("119")));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 80,
              child: Container(
                margin: EdgeInsets.all(25),
                  child: Text(
                    product,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),)),
              decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
            ),
            Container(
              height: 40,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Number of tasks : 10"),
                    Text("Number of customers : 3")
                  ],
                ),),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              productCard("product A", context),
              productCard("product B", context),
              productCard("product C", context),
              productCard("product D", context),
              productCard("product E", context),
            ],
          ),
        ),
      ),
    );
  }
}
