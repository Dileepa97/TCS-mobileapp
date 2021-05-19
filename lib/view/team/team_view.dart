import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timecapturesystem/view/report/team_member_report.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';

class TeamView extends StatefulWidget {
  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {

  List<String> teamMembers = ["Member AL", "Member B", "Member C", "Member K", "Member L", "Member M", "Member S", "Member I", "Member J", "Member M", "Member S", "Member I", "Member J"];

  String selectedMember;

  // ignore: non_constant_identifier_names
  Widget GetTeamMemberList(List<String> strings)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text(strings[i],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                    fontSize: 17
                  ),
                ),
                subtitle: Text('availabile'),
                trailing: RaisedButton(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text("View Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Arial'
                      ),
                    ),
                    onPressed: (){
                      this.selectedMember = strings[i];
                      this.getDateRange(context);
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (BuildContext context)=>TeamMemberReport(strings[i])
//                        )
//                      );
                    },
                    color: Colors.blue,
                  ),
              ),
            ),
          )
      );
    }
    return SingleChildScrollView(child: new Column(children: list));
  }



  void getDateRange(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Select date range',
            style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600,
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text('Select date range to generate team member report.',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    color: Colors.grey.shade600
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Set start date',
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        color: Colors.blue
                      ),
                    )
                ),

                FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Set end date',
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.blue
                      ),
                    )
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
              }, child: Text("Cancel",
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context)=>TeamMemberReport(this.selectedMember)
                ));
              }, child: Text("Confirm",
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


//  Widget getDateRange(BuildContext context){
//    return AlertDialog(
//      title: Text('AlertDialog Title'),
//      content: SingleChildScrollView(
//        child: ListBody(
//          children: <Widget>[
//            Text('This is a demo alert dialog.'),
//            Text('Would you like to approve of this message?'),
//          ],
//        ),
//      ),
//      actions: <Widget>[
//        TextButton(
//          child: Text('Approve'),
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//        ),
//      ],
//    );
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Dashboard",
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: new EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.2,
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
                            Text("Team Alpha",
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
                                    Text("Team Leader : "),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Number of Members :")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Chethiya"),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("12")
                                  ],
                                )
                              ],
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              GetTeamMemberList(this.teamMembers)
            ],
          ),
        ),
      ),
    );
  }
}
