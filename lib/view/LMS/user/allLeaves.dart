import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/services/leaveService.dart';

class MyApp extends StatelessWidget {
  // final Future<List<Product>> products;
  // MyApp({Key key, this.products}) : super(key: key);
  final LeaveService _leaveService = LeaveService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllLeave(leaves: _leaveService.fetchLeaves()),
    );
  }
}

class AllLeave extends StatelessWidget {
  final Future<List<LeaveResponse>> leaves;
  AllLeave({Key key, @required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Leaves',
        ),
      ),
      body: Center(
        child: FutureBuilder<List<LeaveResponse>>(
          future: leaves,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? LeaveBoxList(items: snapshot.data)

                // return the ListView widget :
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class LeaveBoxList extends StatelessWidget {
  final List<LeaveResponse> items;
  LeaveBoxList({Key key, this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: LeaveBox(item: items[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeavePage(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class LeavePage extends StatelessWidget {
  LeavePage({Key key, this.item}) : super(key: key);
  final LeaveResponse item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.userId),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.leaveType,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.leaveDescription),
                            Text(this.item.leaveStartDate.toString()),
                            Text(this.item.leaveEndDate.toString())
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}

class LeaveBox extends StatelessWidget {
  LeaveBox({Key key, this.item}) : super(key: key);
  final LeaveResponse item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.userId,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.leaveType),
                            Text(this.item.leaveStartDate.toString()),
                          ],
                        )))
              ]),
        ));
  }
}
