import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timecapturesystem/models/report/team_member_report.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/report/report_service.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

class TeamMemberReportView extends StatefulWidget {

  static const String id = "team_member_task_report";

  final User teamMember;
  const TeamMemberReportView({this.teamMember});

  @override
  _TeamMemberReportViewState createState() => _TeamMemberReportViewState();
}

class _TeamMemberReportViewState extends State<TeamMemberReportView> {


  bool loading = true;
  TeamMemberReport teamMemberReport ;

  @override
  void initState() {
    super.initState();
    // this.initializeDownloader();
    if(this.loading) {
      getReport().then((value) => {
        setState(() {
          this.teamMemberReport = value;
          Future.delayed(Duration(milliseconds: 1200),(){
            setState(() {
              this.loading = false;
            });
          });
        })
      });
    }
  }

  getReport() async{
    TeamMemberReport teamMemberReport = await ReportService.getTeamMemberReport(widget.teamMember.id);
    return teamMemberReport;
  }


  downloadCsv(User teamMember)async{

    final status =await Permission.storage.request();
    final externalDirectory = await getExternalStorageDirectory();

    if(status.isGranted){
      FlutterDownloader.enqueue(
          url: apiEndpoint + "team-member-report/"+teamMember.id+"/export/csv",
          savedDir: externalDirectory.path,
          fileName: teamMember.fullName+"_"+DateTime.now().year.toString()+".csv",
          showNotification: true,
          openFileFromNotification: true
      );
    }
  }

  Widget taskListView(List<dynamic> teamMemberTaskList) {
    List<Widget> tasksList = new List<Widget>();
    for (int i = 0; i < teamMemberTaskList.length; i++) {

      TeamMemberTask teamMemberTask = TeamMemberTask.formJson(teamMemberTaskList[i]);

      tasksList.add(Container(
        // width: MediaQuery.of(context).size.width * 0.95,\
          padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: new Container(
            padding: EdgeInsets.fromLTRB(10, 10, 15, 0),
            height: MediaQuery.of(context).size.height / 6.5,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teamMemberTask.teamMemberTask.taskName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                SizedBox(height: 8),
                Text("Product : "+teamMemberTask.product.productName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue.shade800,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                SizedBox(height: 8),
                Text("Time Spent : "+teamMemberTask.timeSpent.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue.shade800,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          )
      ));
    }

    return new Column(children: tasksList);
  }

  @override
  Widget build(BuildContext context) {

    if(this.loading){
      return LoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Team Member Report",
            style: TextStyle(
                color: Colors.white
            )),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: new EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.37,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: new EdgeInsets.only(top: 10,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.teamMember.fullName,
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
                                    Text("Task count ",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Total Time Spent ",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Product count ",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Customer count ",
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(this.teamMemberReport.taskCount.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text(this.teamMemberReport.totalHours.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text(this.teamMemberReport.productCount.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text(this.teamMemberReport.customerCount.toString(),
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
                                onPressed: (){
                                  this.downloadCsv(this.teamMemberReport.teamMember);
                                },
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
              this.taskListView(this.teamMemberReport.teamMemberTasks)
            ],
          ),
        ),
      ),
    );

    //return this.getDateRange();
  }
}

