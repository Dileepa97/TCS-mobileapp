import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class TeamMemberReport extends StatefulWidget {

  String teamMember;

  TeamMemberReport(this.teamMember);

  @override
  _TeamMemberReportState createState() => _TeamMemberReportState();
}

class _TeamMemberReportState extends State<TeamMemberReport> {

//  List<charts.Series> seriesList;
//  bool animate;

  Widget getDateRange(BuildContext context){
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }


  // ignore: non_constant_identifier_names
  Widget ItemCard(BuildContext context,String task_name, String product_name, int hours){
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      width: MediaQuery.of(context).size.width * 0.96,
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(50, 20, 100, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Name",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Task Name",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                    ),
                  ),
                  SizedBox(height: 10,
                  ),
                  Text("Hours",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product_name),
                  SizedBox(height: 10),
                  Text(task_name),
                  SizedBox(height: 10,),
                  Text(hours.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Member",
            style: TextStyle(
                color: Colors.black87
            )),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: new EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: new EdgeInsets.only(top: 20,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.teamMember,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Task count  ",
                                      style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Hours",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text(" Product count",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("45",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("120",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("4",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                            Container(
                              height: 50,
                              child: RaisedButton(
                                color: Colors.blue,
                                child: Text("Download CSV",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Arial',
                                    fontSize: 18
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                ),
                                onPressed: (){},
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              this.ItemCard(context,"Task 1","Product A ", 10),
              this.ItemCard(context,"Task 1","Product A ", 10),
              this.ItemCard(context,"Task 1","Product A ", 10),
              this.ItemCard(context,"Task 1","Product A ", 10)
            ],
          ),
        ),
      ),
    );

  //return this.getDateRange();
  }

}
