import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:open_file/open_file.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';

import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

import '../check_leaves.dart';
import 'package:path_provider/path_provider.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
// ignore: non_constant_identifier_names
var API = apiEndpoint + 'files/';

class UserLeaveDetailsPage extends StatefulWidget {
  static const String id = 'user_leave_details_page';

  UserLeaveDetailsPage({this.item});
  final Leave item;

  @override
  _UserLeaveDetailsPageState createState() => _UserLeaveDetailsPageState();
}

class _UserLeaveDetailsPageState extends State<UserLeaveDetailsPage> {
  LeaveService _leaveService = LeaveService();

  ShowAlertDialog _alertDialog = ShowAlertDialog();

  bool downloading = false;
  String progress = '0';
  bool isDownloaded = false;
  String filePath;

  bool _spin = false;

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
      if (this.mounted) {
        this._alertDialog.showAlertDialog(
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
        title: Text(
          EnumToString.convertToString(widget.item.type).substring(0, 1) +
              EnumToString.convertToString(widget.item.type)
                  .substring(1)
                  .toLowerCase()
                  .replaceAll('_', ' ') +
              ' leave',
          style: TextStyle(
            color: Colors.purple[900],
            fontFamily: 'Source Sans Pro',
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.purple[900],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          HomeButton(
            color: Colors.purple[900],
          )
        ],
      ),

      ///Body
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _spin,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ///Icon
                              CircleAvatar(
                                child: CheckType(type: widget.item.type)
                                    .typeIcon(),
                                radius: 25,
                                backgroundColor:
                                    CheckStatus(status: widget.item.status)
                                        .statusColor(),
                                foregroundColor: Colors.white,
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///Leave Status
                                  Text(
                                    EnumToString.convertToString(
                                                widget.item.status)
                                            .substring(0, 1) +
                                        EnumToString.convertToString(
                                                widget.item.status)
                                            .substring(1)
                                            .toLowerCase()
                                            .replaceAll('_', ' '),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CheckStatus(
                                              status: widget.item.status)
                                          .statusColor(),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 19,
                                    ),
                                  ),

                                  ///Requested date
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
                          SizedBox(
                            height: 40,
                          ),

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
                              valueString: CheckMethod.methodString(
                                  widget.item.startDayMethod)),
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
                                  valueString: CheckMethod.methodString(
                                      widget.item.endDayMethod),
                                )
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

                          ///Button
                          this.widget.item.status == LeaveStatus.REQUESTED ||
                                  this.widget.item.status ==
                                      LeaveStatus.ACCEPTED ||
                                  this.widget.item.status == LeaveStatus.ONGOING
                              ? RoundedButton(
                                  title: 'Cancel Leave',
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Widget child = SizedBox();

                                    setState(() {
                                      _spin = true;
                                    });

                                    ///alert dialog
                                    this._alertDialog.showConfirmationDialog(
                                          title: 'Confirm',
                                          context: context,
                                          children: [
                                            Text(
                                                'Do you want to cancel this leave ?'),
                                            child
                                          ],

                                          ///on pressed yes
                                          onPressedYes: () async {
                                            Navigator.pop(context);

                                            int code =
                                                await _leaveService.cancelLeave(
                                                    this.widget.item.id);

                                            if (this.mounted) {
                                              ///if cancelled
                                              if (code == 200) {
                                                this
                                                    ._alertDialog
                                                    .showAlertDialog(
                                                      context: context,
                                                      title: 'Cancelled',
                                                      body:
                                                          'Leave cancelled successfully.',
                                                      color: Colors.blueAccent,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _spin = false;
                                                        });
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                              } else {
                                                this
                                                    ._alertDialog
                                                    .showAlertDialog(
                                                      context: context,
                                                      title: 'Error occured',
                                                      body:
                                                          'Cannot cancel this leave. \nTry again later',
                                                      color: Colors.redAccent,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _spin = false;
                                                        });
                                                      },
                                                    );
                                              }
                                            }
                                          },

                                          ///on pressed no
                                          onPressedNo: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              _spin = false;
                                            });
                                          },
                                        );
                                  },
                                )
                              : SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
