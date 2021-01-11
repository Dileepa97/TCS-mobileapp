import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/leave_component/list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';

class AllLeave extends StatefulWidget {
  @override
  _AllLeaveState createState() => _AllLeaveState();
}

class _AllLeaveState extends State<AllLeave> {
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
          title: Text(
            'All leaves',
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.popAndPushNamed(context, '/userLeave');
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: this._dataAvailable
            ? LeaveListViewBuilder(
                // list: list,
                isUserLeave: false,
              )
            : Center(
                child:
                    Text('Cannot Connect to the server or no available data')),
      ),
    );
  }

  void data() async {
    var data = await _leaveService.getData() as List;
    //print(data);
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
