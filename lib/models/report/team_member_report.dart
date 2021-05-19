import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/models/user/user.dart';

class TeamMemberReport {

  User teamMember;
  int productCount;
  int customerCount;
  int taskCount;
  int totalHours;
  List<dynamic> monthlyTasks;
  List<dynamic> teamMemberTasks;

  TeamMemberReport({
    this.teamMember,
    this.productCount,
    this.customerCount,
    this.taskCount,
    this.totalHours,
    this.monthlyTasks,
    this.teamMemberTasks
 });

  factory TeamMemberReport.formJson(Map<String, dynamic> data){
    return TeamMemberReport(
        teamMember: User.fromJson(data['teamMember']),
        productCount: data['productCount'],
        customerCount: data['customerCount'],
        taskCount: data['taskCount'],
        totalHours: data['totalHours'],
        monthlyTasks: data['monthlyTasks'],
        teamMemberTasks: data['teamMemberTasks'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "teamMember" : this.teamMember,
      "productCount" : this.productCount,
      "customerCount" : this.customerCount,
      "taskCount" : this.taskCount,
      "totalHours" : this.totalHours,
      "monthlyTasks" : this.monthlyTasks,
      "teamMemberTasks" : this.teamMemberTasks
    };
  }

}