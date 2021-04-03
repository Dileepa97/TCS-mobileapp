import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_cancel_card.dart';
import 'package:timecapturesystem/models/lms/leave_cancel_details.dart';
import 'package:timecapturesystem/services/lms/leave_cancel_service.dart';

class OngoingLeaveCancellationManager extends StatefulWidget {
  static const String id = "ongoing_leave_cancellation_manager";

  @override
  _OngoingLeaveCancellationManagerState createState() =>
      _OngoingLeaveCancellationManagerState();
}

class _OngoingLeaveCancellationManagerState
    extends State<OngoingLeaveCancellationManager> {
  LeaveCancelService _leaveCancelService = LeaveCancelService();
  List<LeaveCancelDetails> _cancelDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        title: Text(
          'Cancel requests',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_cancelDetails != null) {
                setState(() {
                  _cancelDetails.removeRange(0, _cancelDetails.length);
                });
              } else {
                setState(() {});
              }
            },
          ),
          HomeButton(),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            ///leave cancel detail list
            FutureBuilder<dynamic>(
              future: _leaveCancelService.getAllLeaveCancelDetails(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text: "No ongoing cancel request to display");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _cancelDetails = snapshot.data;

                    child = ListView.builder(
                      itemCount: _cancelDetails.length,
                      itemBuilder: (context, index) {
                        return LeaveCancelCard(
                          data: _cancelDetails[index],
                        );
                      },
                    );
                  }
                } else {
                  child = LoadingText();
                }

                return Expanded(child: child);
              },
            )
          ],
        ),
      ),
    );
  }
}
