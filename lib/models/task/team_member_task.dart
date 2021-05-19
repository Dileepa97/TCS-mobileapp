import 'dart:convert';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/models/task/task_status.dart';
import 'package:timecapturesystem/models/user/user.dart';

class TeamMemberTask {
  String teamMemberTaskId;
  String teamMemberId;
  Task teamMemberTask;
  User teamMember;
  Customer customer;
  Product product;
  DateTime pickedAt;
  DateTime startAt;
  DateTime updateAt;
  DateTime endTime;
  int timeSpent;
  int additionalTimeSpent;
  String taskStatus;

  TeamMemberTask({
        this.teamMemberTaskId,
        this.teamMemberId,
        this.teamMemberTask,
        this.teamMember,
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
      teamMember: User.fromJson(data['teamMember']),
      teamMemberTask : Task.fromJson(data['task']),
      customer: Customer.fromJson(data['customer']),
      product: Product.fromJson(data['product']),
      pickedAt: data['pickedAt'] == null ? null : DateTime.parse(data['pickedAt'] as String),
      startAt: data['startTime'] == null ? null : DateTime.parse(data['startTime'] as String),
      updateAt: data['updatedTime'] == null ? null : DateTime.parse(data['updatedTime'] as String),
      endTime: data['endTime'] == null ? null : DateTime.parse(data['endTime'] as String),
      timeSpent: data['timeSpent'],
      additionalTimeSpent: data['additionalTimeSpent'],
      taskStatus: data['taskStatus']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "teamMemberTaskId" :this.teamMemberTaskId,
      "teamMemberId":this.teamMemberId,
      "teamMemberTask":this.teamMemberTask,
      "teamMember":this.teamMember,
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