import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/product_dashboard.dart';
import 'package:timecapturesystem/view/widgets/team_leader_drawer.dart';

class TaskPanel extends StatelessWidget {
  Widget productCard(String product, BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListTile(
          title: Text(
            product,
          ),
          subtitle: Text('A sufficiently long subtitle warrants three lines.'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductDashboard()));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
