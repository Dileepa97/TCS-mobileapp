import 'package:timecapturesystem/models/user/user.dart';

class Team {

  String id;
  String teamName;
  User teamLeader;
  List<dynamic> teamMemberList;

  Team({
    this.id,
    this.teamName,
    this.teamLeader,
    this.teamMemberList
  });

  factory Team.formJson(Map<String, dynamic> data){
    return Team(
        id: data['id'],
        teamName: data['teamName'],
        teamLeader: User.fromJson(data['teamLeader']),
        teamMemberList : data['teamMemberList']
//        teamMemberList : data['teamMemberList'].map((user){
//          return new User.fromJson(user);
//        }),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" :this.id,
      "teamName":this.teamName,
      "teamLeader":this.teamLeader,
      "teamMemberList":this.teamMemberList,
    };
  }

}