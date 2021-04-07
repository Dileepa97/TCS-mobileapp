import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/models/task/task_status.dart';

class Task{
  String taskId;
  String taskName;
  String taskStatus;
  int estimatedHours;
  String startTime;
  String endTime;
  Customer customer;

  Task({
  this.taskId,
  this.taskName,
  this.taskStatus,
  this.estimatedHours,
  this.startTime,
  this.endTime,
  this.customer
  });

  factory Task.formJson(Map<String, dynamic> data){
    return Task(
      taskId: data['taskId'],
      taskName: data['taskName'],
      taskStatus: data['taskStatus'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      customer: data['customer'],
      estimatedHours: data['estimatedHours'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
        "taskId": this.taskId,
        "taskName": this.taskName,
        "taskStatus": this.taskStatus,
        "startTime": this.startTime,
        "endTime": this.startTime,
        "customer": this.customer,
        "estimatedHours": this.estimatedHours
    };
  }

}