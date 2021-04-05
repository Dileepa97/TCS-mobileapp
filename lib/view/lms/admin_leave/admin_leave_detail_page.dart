import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/button_row.dart';

import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';
import 'package:timecapturesystem/services/LMS/leave_service.dart';
import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';

import '../check_leaves.dart';
import 'admin_user_leave_detail_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'files/';

class AdminLeaveDetailsPage extends StatefulWidget {
  static const String id = 'admin_leave_details_page';

  AdminLeaveDetailsPage({this.item});
  final Leave item;

  @override
  _AdminLeaveDetailsPageState createState() => _AdminLeaveDetailsPageState();
}

class _AdminLeaveDetailsPageState extends State<AdminLeaveDetailsPage> {
  LeaveService _leaveService = LeaveService();

  ShowAlertDialog _dialog = ShowAlertDialog();

  bool downloading = false;
  String progress = '0';
  bool isDownloaded = false;
  String filePath;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  ///get storage permission
  void getPermission() async {
    await Permission.storage.request();
  }

  ///get file from url
  Future downloadFile(String url, String savePath) async {
    try {
      setState(() {
        downloading = true;
      });

      filePath = savePath;

      Dio dio = Dio();

      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      setState(() {
        isDownloaded = true;
      });
    } catch (e) {
      ///if error
      setState(() {
        downloading = false;
      });
      this._dialog.showAlertDialog(
            context: context,
            title: 'Download Error',
            body: 'This file cannot download',
            color: Colors.redAccent,
            onPressed: () {
              Navigator.pop(context);
            },
          );
    }
  }

  ///progress indicator
  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        progress = (received / total * 100).toStringAsFixed(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///App Bar
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
      ),

      ///Body
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    ///
                    Row(
                      children: [
                        ///Profile image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserProfileImage(
                              userId: widget.item.userId,
                              height: 60,
                              width: 60),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///User name
                            UserNameText(
                                userId: widget.item.userId, fontSize: 18),

                            //Requested date
                            Text(
                              'Requested date : ' +
                                  widget.item.reqDate
                                      .toIso8601String()
                                      .substring(0, 10),
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),

                            ///Requested time
                            Text(
                              'Requested time : ' +
                                  widget.item.reqDate
                                      .toIso8601String()
                                      .substring(11, 16),
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ///
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Title
                          Text(
                            this.widget.item.title,
                            style: TextStyle(
                              color: Colors.cyan[800],
                              fontFamily: 'Source Sans Pro',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///Leave type
                              Text(
                                EnumToString.convertToString(widget.item.type)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.type)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ///type & status Icon
                              CircleAvatar(
                                child: CheckType(type: widget.item.type)
                                    .typeIcon(),
                                radius: 15,
                                backgroundColor:
                                    CheckStatus(status: widget.item.status)
                                        .statusColor(),
                                foregroundColor: Colors.white,
                              ),

                              ///Leave Status
                              Text(
                                EnumToString.convertToString(widget.item.status)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.status)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CheckStatus(status: widget.item.status)
                                      .statusColor(),
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          ///Start date
                          DetailRow(
                            keyString: 'Start Date',
                            valueString: widget.item.startDate
                                .toIso8601String()
                                .substring(0, 10),
                          ),
                          SizedBox(height: 5),

                          ///Start day method
                          DetailRow(
                              keyString: 'Start Day Method',
                              valueString: EnumToString.convertToString(
                                          widget.item.startDayMethod)
                                      .substring(0, 1) +
                                  EnumToString.convertToString(
                                          this.widget.item.startDayMethod)
                                      .substring(1)
                                      .toLowerCase()
                                      .replaceAll('_', ' ')),
                          SizedBox(height: 5),

                          ///End date
                          this.widget.item.endDate != null
                              ? DetailRow(
                                  keyString: 'End Date',
                                  valueString: widget.item.endDate
                                      .toIso8601String()
                                      .substring(0, 10))
                              : SizedBox(),
                          this.widget.item.endDate != null
                              ? SizedBox(height: 5)
                              : SizedBox(),

                          ///End day method
                          this.widget.item.endDate != null
                              ? DetailRow(
                                  keyString: 'End Day Method',
                                  valueString: EnumToString.convertToString(
                                              widget.item.endDayMethod)
                                          .substring(0, 1) +
                                      EnumToString.convertToString(
                                              this.widget.item.endDayMethod)
                                          .substring(1)
                                          .toLowerCase()
                                          .replaceAll('_', ' '))
                              : SizedBox(),
                          this.widget.item.endDate != null
                              ? SizedBox(height: 5)
                              : SizedBox(),

                          ///Leave days
                          DetailRow(
                              keyString: 'Leave Days',
                              valueString: this.widget.item.days.toString()),
                          SizedBox(height: 5),

                          ///Leave taken days
                          this.widget.item.takenDays != 0
                              ? DetailRow(
                                  keyString: 'Taken Days',
                                  valueString:
                                      this.widget.item.takenDays.toString())
                              : SizedBox(),

                          ///Description
                          this.widget.item.description != null &&
                                  this.widget.item.description != ""
                              ? SizedBox(
                                  height: 30,
                                  child: Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                )
                              : SizedBox(),
                          this.widget.item.description != null &&
                                  this.widget.item.description != ""
                              ? DetailRow(
                                  keyString: 'Description', valueString: '')
                              : SizedBox(),
                          this.widget.item.description != null &&
                                  this.widget.item.description != ""
                              ? Text(
                                  this.widget.item.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Source Sans Pro',
                                    color: Colors.blueGrey[600],
                                  ),
                                )
                              : SizedBox(),

                          ///Reject reason
                          this.widget.item.rejectReason != null &&
                                  this.widget.item.rejectReason != ""
                              ? SizedBox(
                                  height: 30,
                                  child: Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                )
                              : SizedBox(),
                          this.widget.item.rejectReason != null &&
                                  this.widget.item.rejectReason != ""
                              ? DetailRow(
                                  keyString: 'Rejected Reason', valueString: '')
                              : SizedBox(),
                          this.widget.item.rejectReason != null &&
                                  this.widget.item.rejectReason != ""
                              ? Text(
                                  this.widget.item.rejectReason,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Source Sans Pro',
                                    color: Colors.blueGrey[600],
                                  ),
                                )
                              : SizedBox(),

                          ///attachment url
                          this.widget.item.attachmentURL != null &&
                                  this.widget.item.attachmentURL != ""
                              ? SizedBox(
                                  height: 30,
                                  child: Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                )
                              : SizedBox(),
                          this.widget.item.attachmentURL != null &&
                                  this.widget.item.attachmentURL != ""
                              ? DetailRow(
                                  keyString: 'Attachment', valueString: '')
                              : SizedBox(),
                          this.widget.item.attachmentURL != null &&
                                  this.widget.item.attachmentURL != ""
                              ? Column(
                                  children: [
                                    ///attachment name
                                    Text(
                                      this.widget.item.attachmentURL,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Source Sans Pro',
                                        color: Colors.blueGrey[600],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    ///Download button
                                    ElevatedButton(
                                      onPressed: () async {
                                        Directory dir =
                                            await getApplicationDocumentsDirectory();
                                        String path = dir.path +
                                            '/' +
                                            this.widget.item.attachmentURL;

                                        ///storage/emulated/0/Download   --> android download directory
                                        await downloadFile(
                                            API +
                                                this.widget.item.attachmentURL,
                                            path);
                                      },
                                      child: const Text("Download file"),
                                    ),

                                    ///downloading progress
                                    downloading
                                        ? Text('$progress%')
                                        : SizedBox(),

                                    ///open file
                                    isDownloaded
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'File Downloaded! Click here to open',
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onTap: () {
                                                  OpenFile.open(filePath);
                                                },
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                )
                              : SizedBox(),

                          ///
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          ///user leave detail button
                          GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0, color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  'User Leave Details',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              ///on tap function
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, MoreLeaveDetails.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoreLeaveDetails(
                                      userId: this.widget.item.userId,
                                    ),
                                  ),
                                );
                              }),

                          ///
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),

                          ///Buttons
                          this.widget.item.status == LeaveStatus.REQUESTED
                              ? TwoButtonRow(
                                  title1: 'Accept',
                                  title2: 'Reject',

                                  ///accept leave
                                  onPressed1: () {
                                    this._dialog.showConfirmationDialog(
                                          title: 'Confirm',
                                          context: context,

                                          ///dialog body
                                          children: [
                                            Text(
                                                'Do you want to accept this leave request?')
                                          ],

                                          ///on pressed yes
                                          onPressedYes: () async {
                                            int code = await _leaveService
                                                .acceptOrReject(
                                                    this.widget.item.id,
                                                    'ACCEPTED',
                                                    "");
                                            if (code == 200) {
                                              Navigator.pop(context);
                                              this._dialog.showAlertDialog(
                                                    context: context,
                                                    title: 'Accepted',
                                                    body:
                                                        'Leave accepted successfully.',
                                                    color: Colors.blueAccent,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                            } else {
                                              Navigator.pop(context);
                                              this._dialog.showAlertDialog(
                                                    context: context,
                                                    title: 'Error occured',
                                                    body:
                                                        'Cannot accept this leave. \nTry again later',
                                                    color: Colors.redAccent,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                            }
                                          },

                                          ///on pressed no
                                          onPressedNo: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                  },

                                  ///reject leave
                                  onPressed2: () async {
                                    String reason = "";

                                    this._dialog.showConfirmationDialog(
                                          title: 'Confirm',
                                          context: context,

                                          ///dialog body
                                          children: [
                                            Text(
                                                'Do you want to reject this leave request?'),
                                            TextField(
                                                decoration: InputDecoration(
                                                    hintText: 'Reason'),
                                                maxLines: null,
                                                onChanged: (text) {
                                                  setState(() {
                                                    reason = text;
                                                  });
                                                })
                                          ],

                                          ///on pressed yes
                                          onPressedYes: () async {
                                            int code = await _leaveService
                                                .acceptOrReject(
                                                    this.widget.item.id,
                                                    'REJECTED',
                                                    reason);

                                            if (code == 200) {
                                              Navigator.pop(context);
                                              this._dialog.showAlertDialog(
                                                    context: context,
                                                    title: 'Rejected',
                                                    body:
                                                        'Leave rejected successfully.',
                                                    color: Colors.blueAccent,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                            } else {
                                              Navigator.pop(context);
                                              this._dialog.showAlertDialog(
                                                    context: context,
                                                    title: 'Error occured',
                                                    body:
                                                        'Cannot reject this leave. \nTry again later',
                                                    color: Colors.redAccent,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                            }
                                          },

                                          ///on pressed no
                                          onPressedNo: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                  },
                                )
                              : SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
