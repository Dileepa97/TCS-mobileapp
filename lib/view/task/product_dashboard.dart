import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/add_tasks.dart';
import 'package:timecapturesystem/view/task/delete_task.dart';
import 'package:timecapturesystem/view/task/update_task_list_view.dart';
import 'package:timecapturesystem/view/task/view_tasks.dart';
import 'package:timecapturesystem/view/widgets/team_leader_drawer.dart';

// ignore: must_be_immutable
class ProductDashboard extends StatefulWidget {
  static const String id = "product_dashboard";

  final Product product;

  const ProductDashboard({Key key, this.product}) : super(key: key);

  @override
  _ProductDashboardState createState() => _ProductDashboardState();
}

class _ProductDashboardState extends State<ProductDashboard> {
  @override
  void initState() {
    super.initState();
  }

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
                  builder: (BuildContext context) => ViewTasks(product: widget.product,)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title:
        Text("Product Dashboard", style: TextStyle(color: Colors.white,fontFamily: 'Arial',)),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
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
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white,),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.blue.shade800,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "View Task",
                          style: TextStyle(color: Colors.blue.shade800, fontSize: 20,fontFamily: 'Arial',),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ViewTasks(product: widget.product,)));
                  },
                ),
              ),
            ),
            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white,),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue.shade800,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Add Task",
                          style: TextStyle(color: Colors.blue.shade800, fontSize: 20,fontFamily: 'Arial',),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddTask(product: widget.product,)));
                  },
                ),
              ),
            ),
            Material(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white,),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.blue.shade800,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Update Task",
                          style: TextStyle(color: Colors.blue.shade800, fontSize: 20,fontFamily: 'Arial',),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UpdateTaskListView(product: widget.product,)));
                  },
                ),
              ),
            ),
            Material(
              elevation: 0,
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
                          color: Colors.blue.shade800,
                          size: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Delete Task",
                          style: TextStyle(color: Colors.blue.shade800, fontSize: 20,fontFamily: 'Arial',),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DeleteTask(product: widget.product,)));
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
