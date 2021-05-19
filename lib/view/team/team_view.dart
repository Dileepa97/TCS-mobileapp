import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/team/team.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/team/team_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/report/team_member_report_view.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var fileAPI = apiEndpoint + 'files/';

class TeamView extends StatefulWidget {
  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  
  User selectedMember;
  bool loading = true;
  Team team;

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getTeamDetails();
    }
  }

  getTeamDetails() async{
    User user =await UserService.getLoggedInUser();
    Team team = await TeamService.getTeamById(user.teamId);
    setState(() {
      this.team = team;
      this.loading = false;
    });
  }

  // ignore: non_constant_identifier_names
  Widget GetTeamMemberList(List<dynamic> teamMemberList)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < teamMemberList.length+1; i++){
      User teamMember;
      if(i==0){
        teamMember = this.team.teamLeader;
      }else {
        teamMember = User.fromJson(teamMemberList[i-1]);
      }
      list.add(
          Container(
            width: MediaQuery.of(context).size.width * 0.96,
            child: InkWell(

              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context)=>TeamMemberReportView(teamMember: teamMember,))
                );
              },

              child: Container(
                // width: MediaQuery.of(context).size.width * 0.95,\
                padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                child: new Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: MediaQuery.of(context).size.width / 10,
                          backgroundImage: teamMember.profileImageURL == 'default.png'
                              ? AssetImage('images/default.png')
                              : NetworkImage(fileAPI + teamMember.profileImageURL),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(teamMember.fullName,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.blue.shade800,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                            Text((() {
                              if(teamMember.highestRoleIndex == 1){
                                return "Team Leader";
                              }else if(teamMember.highestRoleIndex == 0)
                              return "Team Member";
                            })(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                            Text(teamMember.gender,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                            Text((() {
                              if(teamMember.probationary){
                                return "Probationary*";}
                              return "";
                            })(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      );
    }
    return SingleChildScrollView(child: new Column(children: list));
  }



  @override
  Widget build(BuildContext context) {

    if(this.loading){
      return LoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text("Team Dashboard",
            style: TextStyle(
                color: Colors.white
            )),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white ,
        ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: (this.team == 1) ? Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
              child: Center(
                child: Text("No Tasks found",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),),
              )
          ) : Column(
            children: [
              Container(
                margin: new EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: new EdgeInsets.only(top: 20,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(team.teamName,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Team Leader "),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("Members ")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(": "+team.teamLeader.fullName,style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent,
                                    ),),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text(": "+team.teamMemberList.length.toString(),style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent,
                                    ),)
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
              GetTeamMemberList(this.team.teamMemberList)
            ],
          ),
        ),
      ),
    );
  }
}
