import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/models/task/task_status.dart';

class TeamMemberTask {
  String teamMemberTaskId;
  String teamMemberId;
  Customer customer;
  Product product;
  DateTime pickedAt;
  DateTime startAt;
  DateTime updateAt;
  DateTime endTime;
  int timeSpent;
  int additionalTimeSpent;
  TaskStatus taskStatus;

  TeamMemberTask({
        this.teamMemberTaskId,
        this.teamMemberId,
        this.customer,
        this.product,
        this.pickedAt,
        this.startAt,
        this.updateAt,
        this.endTime,
        this.timeSpent,
        this.additionalTimeSpent,
        this.taskStatus
  });

  factory TeamMemberTask.formJson(Map<String, dynamic> data){
    return TeamMemberTask(
      teamMemberTaskId: data['id'],
      teamMemberId: data['teamMemberId'],
      customer: data['customer'],
      product: data['product'],
      pickedAt: data['pickedAt'],
      startAt: data['startTime'],
      updateAt: data['updatedTime'],
      endTime: data['endTime'],
      timeSpent: data['timeSpent'],
      additionalTimeSpent: data['additionalTimeSpent'],
      taskStatus: data['taskStatus']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "teamMemberTaskId" :this.teamMemberTaskId,
      "teamMemberId":this.teamMemberId,
      "customer":this.customer,
      "product":this.product,
      "pickedAt":this.pickedAt,
      "startTime":this.startAt,
      "updatedTime":this.updateAt,
      "endTime":this.endTime,
      "timeSpent":this.timeSpent,
      "additionalTimeSpent":this.additionalTimeSpent,
      "taskStatus":this.taskStatus
    };
  }

}