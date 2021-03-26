import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/display_card.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/leave_day_allocation.dart';
import 'package:timecapturesystem/services/lms/leave_day_allocation_controller.dart';

class ChangeAllowedDays extends StatefulWidget {
  static const String id = "change_allowed_day_screen";

  @override
  _ChangeAllowedDaysState createState() => _ChangeAllowedDaysState();
}

class _ChangeAllowedDaysState extends State<ChangeAllowedDays> {
  LeaveDayAllocationService _allocationService = LeaveDayAllocationService();

  List<String> _leaveTypes = [
    'CASUAL',
    'ANNUAL',
    'MEDICAL',
    'EXTENDED_ANNUAL',
    'EXTENDED_MEDICAL',
    'LIEU',
    'MATERNITY',
    'PATERNITY',
  ];

  String leaveType = 'CASUAL';
  String days;
  ShowAlertDialog _dialog = ShowAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Days allowed for leaves",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(10),
                // height: 288,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: FutureBuilder<dynamic>(
                  future: _allocationService.getAllLeaves(context),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget child;
                    if (snapshot.hasData) {
                      List<LeaveDayAllocation> leaves;

                      if (snapshot.data == 400) {
                        child = Center(child: Text("Bad request"));
                      } else if (snapshot.data == 204) {
                        child = Center(
                            child:
                                Text("No leave data available for this month"));
                      } else if (snapshot.data == 1) {
                        child = Center(child: Text("An unknown error occured"));
                      } else {
                        leaves = snapshot.data;
                        // print(leaves);
                        child = ListView.builder(
                            itemCount: leaves.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 38,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(EnumToString.convertToString(
                                                  leaves[index].type)
                                              .substring(0, 1) +
                                          EnumToString.convertToString(
                                                  leaves[index].type)
                                              .substring(1)
                                              .toLowerCase()
                                              .replaceAll('_', ' ')),
                                      Text('${leaves[index].allowedDays}'),
                                    ],
                                  ));
                            });
                      }
                    } else {
                      child = Center(child: Text("Please wait..."));
                    }

                    return child;
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Change allowed days',
                        style: TextStyle(
                          fontSize: 15,
                          // color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomDropDown(
                            keyString: 'Leave Type',
                            item: this.leaveType,
                            items: this._leaveTypes,
                            onChanged: (String newValue) {
                              setState(() {
                                this.leaveType = newValue;
                              });
                            },
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Days",
                                labelStyle: TextStyle(color: Colors.blue[700]),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue[700],
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              // enabled: false,
                              onChanged: (value) {
                                setState(() {
                                  this.days = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        color: Colors.blue[500],
                        child: Text(
                          'Change',
                          style: TextStyle(color: Colors.white),
                        ),
                        minWidth: 100.0,
                        onPressed: () {
                          if (this.days == null) {
                            _dialog.showAlertDialog(
                              title: 'Something Missing !',
                              body: 'Enter number of days',
                              color: Colors.redAccent,
                              context: context,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          } else {
                            print(days);
                            this._dialog.showConfirmationDialog(
                              title: 'Confirm',
                              onPressedYes: () async {
                                print(days);
                                int code =
                                    await _allocationService.changeAllowedDays(
                                        this.leaveType, this.days);
                                if (code == 200) {
                                  // Navigator.pushReplacementNamed(
                                  //     context, '/adminGetLeaves');
                                  // ModalRoute.withName(
                                  //     '/adminGetLeaves');
                                  // Navigator.of(context).pushNamedAndRemoveUntil(
                                  //     '/userLeave',
                                  //     (Route<dynamic> route) => false);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                              onPressedNo: () {
                                Navigator.pop(context);
                              },
                              context: context,
                              children: [
                                Text(
                                    'By taking this action allowed leaves for selected leave type will change for every user')
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
