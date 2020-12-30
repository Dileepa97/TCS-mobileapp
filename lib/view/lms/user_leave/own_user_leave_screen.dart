import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/leave_component/list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

class OwnLeaves extends StatefulWidget {
  @override
  _OwnLeavesState createState() => _OwnLeavesState();
}

class _OwnLeavesState extends State<OwnLeaves> {
  LeaveService _leaveService = LeaveService();
  List<LeaveResponse> list = List<LeaveResponse>();
  bool _spin = true;
  bool _dataAvailable = false;

  @override
  Widget build(BuildContext context) {
    data();
    return ModalProgressHUD(
      inAsyncCall: _spin,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My leaves'),
          leading: BackButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/userLeave');
            },
          ),
        ),
        body: this._dataAvailable
            ? LeaveListViewBuilder(
                list: list,
                isUserLeave: true,
              )
            : Center(child: Text('Cannot Connect to the server')),
      ),
    );
  }

  void data() async {
    var data = await _leaveService.getAUserLeaves("U002") as List;

    List<LeaveResponse> arr = data
        .map((leaveResponseJson) => LeaveResponse.fromJson(leaveResponseJson))
        .toList();

    arr.sort((b, a) => a.reqDate.compareTo(b.reqDate));

    if (this.mounted) {
      setState(() {
        list = arr;
        this._spin = false;
        this._dataAvailable = true;
      });
    }
  }
}