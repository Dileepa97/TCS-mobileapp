import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/add_tasks.dart';
import 'package:timecapturesystem/view/task/delete_task.dart';
import 'package:timecapturesystem/view/task/update_task.dart';
import 'package:timecapturesystem/view/task/view_tasks.dart';
import 'package:timecapturesystem/view/widgets/team_leader_drawer.dart';

// ignore: must_be_immutable
class ProductDashboard extends StatelessWidget {
  static const String id = "product_dashboard";

  final Product product;

  const ProductDashboard({Key key, this.product}) : super(key: key);

  // String productId;

  // ProductDashboard(String productId) {
  //   this.productId = productId;
  // }

  Widget taskDashboardCard(
    String optionTitle,
    BuildContext context,
    IconData optionIcon,
  ) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                optionIcon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                optionTitle,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ViewTasks("110")));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Product Dashboard", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: SideDrawer(),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          shrinkWrap: true,
          childAspectRatio: (itemWidth / itemHeight),
          physics: ScrollPhysics(),
          children: [
            Material(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black87,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "View Task",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ViewTasks("110")));
                  },
                ),
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.black87,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Add Task",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddTask()));
                  },
                ),
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.black87,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Update Task",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UpdateTask()));
                  },
                ),
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black87,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Delete Task",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DeleteTask()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
