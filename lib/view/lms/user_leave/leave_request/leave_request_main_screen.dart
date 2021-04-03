import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';

import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';

import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_date.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';

import 'leave_request_confirmation_screen.dart';

class LeaveRequestMainScreen extends StatefulWidget {
  static const String id = "user_leave_request_main_screen";

  final String leaveType;
  final double availableDays;
  final bool isMatOrPat;

  const LeaveRequestMainScreen(
      {Key key, this.leaveType, this.availableDays, this.isMatOrPat})
      : super(key: key);

  @override
  _LeaveRequestMainScreenState createState() => _LeaveRequestMainScreenState();
}

class _LeaveRequestMainScreenState extends State<LeaveRequestMainScreen> {
  String _leaveTitle;
  String _leaveDescription = '';

  bool _multiDayLeave = false;
  bool _spin = false;
  bool _isFile = false;
  bool _loadingPath = false;

  DateTime _startDate;
  DateTime _endDate;

  String _startDayMethod;
  String _endDayMethod;

  List<String> _leaveMethod1 = ['FIRST_HALF', 'SECOND_HALF', 'FULL'];
  List<String> _leaveMethod2 = ['SECOND_HALF', 'FULL'];
  List<String> _leaveMethod3 = ['FIRST_HALF', 'FULL'];

  File file;

  ShowAlertDialog check = ShowAlertDialog();
  LeaveService _leaveService = LeaveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'Leave Request',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        actions: [
          HomeButton(),
        ],
      ),

      ///body
      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          ///request form
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///form header
                Text(
                  'Create New Leave',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.lightBlue.shade800,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DividerBox(),

                ///leave title
                _buildTitle(),

                ///leave description
                _buildDescription(),
                DividerBox(),

                ///leave check box
                _buildCheckBox(),

                ///leave start date
                _buildStartDate(),

                ///leave start day method
                _buildStartDayMethod(),
                DividerBox(),

                ///leave end date
                _buildEndDate(),

                ///leave end day method
                _buildEndDayMethod(),

                ///select attachment
                _buildFilePicker(),

                ///button
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Request',
                  minWidth: 200.0,
                  onPressed: () async {
                    setState(() {
                      _spin = true;
                    });

                    if (_checkCondition() &&
                        await _checkDate() &&
                        await _checkCount()) {
                      if (this._multiDayLeave == false) {
                        this._endDayMethod = 'NO';
                      }

                      setState(() {
                        _spin = false;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RequestConfirmationScreen(
                            leaveType: widget.leaveType,
                            leaveTitle: this._leaveTitle,
                            leaveDescription: this._leaveDescription,
                            startDate: this._startDate,
                            startDayMethod: this._startDayMethod,
                            endDate: this._endDate,
                            endDayMethod: this._endDayMethod,
                            file: this.file,
                            isFile: this._isFile,
                          );
                        }));
                      });
                    } else {
                      setState(() {
                        _spin = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///leave select file
  Widget _buildFilePicker() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _openFileExplorer(),
              child: const Text("Select file"),
            ),
            Text('(Optional) \nMax file size: 2MB'),
          ],
        ),
        Builder(
          builder: (BuildContext context) => _loadingPath
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: const CircularProgressIndicator(),
                )
              : _isFile
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 40,
                      child: Text(
                        'File: ' + file.path.split('/').last,
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 16,
                        ),
                      ),
                    )
                  : SizedBox(),
        ),
      ],
    );
  }

  ///open mobile file explorer
  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (result != null) {
        print(result.files.single.path);
        file = File(result.files.single.path);
        setState(() {
          _isFile = true;
        });
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
    });
  }

  ///check if any required data missed
  bool _checkCondition() {
    ///if leave title missing
    if (this._leaveTitle == null) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter leave title',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if leave start date missing
    else if (this._startDate == null) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Select leave start date',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if leave start day option missing
    else if (this._startDayMethod == null && this.widget.isMatOrPat == false) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Select leave start day option',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if leave end date missing
    else if (this._multiDayLeave == true) {
      if (_endDate == null) {
        check.showAlertDialog(
          title: 'Something Missing !',
          body: 'Select leave end date',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return false;
      }

      ///if leave end day option missing
      else if (this._endDayMethod == null) {
        check.showAlertDialog(
          title: 'Something Missing !',
          body: 'Select leave end day option',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return false;
      }
    }

    ///if nothing missed
    return true;
  }

  ///check if requested date exist or not
  Future<bool> _checkDate() async {
    String startDate = this._startDate.toIso8601String();
    String endDate;

    if (this._endDate == null) {
      endDate = "";
    } else
      endDate = this._endDate.toIso8601String();

    //TODO: daycount from backend
    if (this.widget.leaveType == 'MATERNITY') {
      endDate = this._startDate.add(Duration(days: 179)).toIso8601String();
    }

    if (this.widget.leaveType == 'PATERNITY') {
      endDate = this._startDate.add(Duration(days: 9)).toIso8601String();
    }

    dynamic code = await _leaveService.leaveDateExist(startDate, endDate);

    if (code == 204) {
      ///if date not exist

      return true;
    } else if (code == 1 || code == -1) {
      /// if any error occured

      check.showAlertDialog(
        title: 'Error occured !',
        body:
            'Error occured while checking requested dates are exist. \nTry again ',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    } else {
      ///if date exist

      check.showAlertDialog(
        title: 'Bad Input !',
        body: '$code' + '. \nTry another date',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }
  }

  /// check if requested date range is accepted or not
  Future<bool> _checkCount() async {
    if (this.widget.leaveType == 'LIEU' ||
        this.widget.leaveType == 'EXTENDED_ANNUAL' ||
        this.widget.leaveType == 'EXTENDED_MEDICAL' ||
        this.widget.leaveType == 'MATERNITY' ||
        this.widget.leaveType == 'PATERNITY') {
      ///do not consider these types

      return true;
    }

    String startDate = this._startDate.toIso8601String();
    String startDayMethod = this._startDayMethod;
    String endDate;
    String endDayMethod;

    if (this._endDate == null) {
      endDate = "";
      endDayMethod = 'NO';
    } else {
      endDate = this._endDate.toIso8601String();
      endDayMethod = this._endDayMethod;
    }

    dynamic code = await _leaveService.checkLeaveDayCounts(
        startDate, startDayMethod, endDate, endDayMethod);

    double count = double.parse(code);

    if (count == -1.0) {
      ///if error occured

      check.showAlertDialog(
        title: 'Error occured !',
        body: 'Error occured while checking day count. \nTry again ',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    } else if (count <= this.widget.availableDays) {
      /// if acceptable

      return true;
    } else {
      /// if not acceptable

      check.showAlertDialog(
        title: 'Bad Input !',
        body:
            'You have only ${this.widget.availableDays} days for this leave type. \nYou requested $count days. \nTry another leave type or date range. ',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }
  }

  ///leave check box
  Widget _buildCheckBox() {
    return widget.isMatOrPat == false
        ? Row(
            children: [
              Text(
                'Multiple Day leaves : ',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 16,
                ),
              ),
              Checkbox(
                value: this._multiDayLeave,
                onChanged: (bool value) {
                  setState(() {
                    this._multiDayLeave = value;
                    this._startDayMethod = null;
                    this._endDayMethod = null;
                    this._endDate = null;
                  });
                },
              ),
            ],
          )
        : SizedBox();
  }

  ///leave title widget
  Widget _buildTitle() {
    return InputContainer(
      child: InputTextField(
        labelText: 'Leave Title',
        onChanged: (text) {
          setState(() {
            this._leaveTitle = text;
          });
        },
      ),
    );
  }

  ///leave description widget
  Widget _buildDescription() {
    return InputContainer(
      child: InputTextField(
        maxLines: null,
        labelText: 'Leave Description (Optional)',
        onChanged: (text) {
          setState(() {
            this._leaveDescription = text;
          });
        },
      ),
    );
  }

  ///leave start day method widget
  Widget _buildStartDayMethod() {
    return widget.isMatOrPat == false
        ? InputContainer(
            child: CustomDropDown(
              keyString: 'Start Day Option',
              item: this._startDayMethod,
              items:
                  this._multiDayLeave ? this._leaveMethod2 : this._leaveMethod1,
              onChanged: (String value) {
                setState(() {
                  this._startDayMethod = value;
                });
              },
            ),
          )
        : SizedBox();
  }

  ///leave start date widget
  Widget _buildStartDate() {
    DateTime initDate = DateTime.now();

    if (initDate.weekday == 6) {
      initDate = initDate.add(Duration(days: 2));
    } else if (initDate.weekday == 7) {
      initDate = initDate.add(Duration(days: 1));
    }

    return InputContainer(
      height: 45.0,
      child: InputDate(
        keyString: 'Leave Start Date : ',
        date: this._startDate,
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: initDate,
                  firstDate: initDate,
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  selectableDayPredicate: (DateTime val) =>
                      val.weekday == 6 || val.weekday == 7 ? false : true,
                  initialEntryMode: DatePickerEntryMode.input)
              .then((datePicked) {
            setState(() {
              this._startDate = datePicked;
              this._endDate = null;
            });
          });
        },
      ),
    );
  }

  ///leave end date widget
  Widget _buildEndDate() {
    if (this._multiDayLeave) {
      DateTime nextdate;
      DateTime initDate;

      if (this._startDate != null) {
        nextdate = this._startDate.add(Duration(days: 1));
        nextdate.weekday == 6 || nextdate.weekday == 7
            ? initDate = this._startDate.add(Duration(days: 3))
            : initDate = this._startDate.add(Duration(days: 1));
      }

      return InputContainer(
        height: 45.0,
        child: InputDate(
            keyString: 'Leave End Date : ',
            date: this._endDate,
            onTap: () {
              this._startDate != null
                  ? showDatePicker(
                          context: context,
                          initialDate: initDate,
                          firstDate: initDate,
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          selectableDayPredicate: (DateTime val) =>
                              val.weekday == 6 || val.weekday == 7
                                  ? false
                                  : true,
                          initialEntryMode: DatePickerEntryMode.input)
                      .then((date) {
                      setState(() {
                        this._endDate = date;
                      });
                    })
                  : check.showAlertDialog(
                      title: 'Something Missing !',
                      body: 'Select leave start date',
                      color: Colors.redAccent,
                      context: context,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
            }),
      );
    } else
      return SizedBox(
        height: 0.0,
      );
  }

  ///leave endday method widget
  Widget _buildEndDayMethod() {
    if (this._multiDayLeave) {
      return Column(
        children: [
          InputContainer(
            child: CustomDropDown(
              keyString: 'End Day Option',
              item: this._endDayMethod,
              items:
                  this._multiDayLeave ? this._leaveMethod3 : this._leaveMethod1,
              onChanged: (String value) {
                setState(() {
                  this._endDayMethod = value;
                });
              },
            ),
          ),
          DividerBox(),
        ],
      );
    } else
      return SizedBox(
        height: 0.0,
      );
  }
}
