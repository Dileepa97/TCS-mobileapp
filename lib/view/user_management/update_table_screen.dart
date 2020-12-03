import 'package:flutter/material.dart';
import 'package:timecapturesystem/managers/orientation.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/models/user/user_history.dart';

class UserUpdateTable extends StatefulWidget {
  final User user;
  final UserHistory userHistory;

  UserUpdateTable(this.user, this.userHistory);

  @override
  _UserUpdateTableState createState() => _UserUpdateTableState();
}

class _UserUpdateTableState extends State<UserUpdateTable> {
  @override
  Widget build(BuildContext context) {
    OrientationManager.enableRotation();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Center(
                child: Container(
                  child: Text('Please rotate your phone',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 27)),
                ),
              )
            : Container(
                child: ListView(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    'Update History',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Attribute',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      DataColumn(
                          label: Text('Current',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      DataColumn(
                          label: Text('Previous',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                    rows: [
                      if (widget.userHistory.username != null)
                        DataRow(cells: [
                          DataCell(Text('Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.username,
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(widget.userHistory.username,
                              style: TextStyle(color: Colors.white))),
                        ]),
                      if (widget.userHistory.fullName != null)
                        DataRow(cells: [
                          DataCell(Text('Full Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.fullName,
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(widget.userHistory.fullName,
                              style: TextStyle(color: Colors.white))),
                        ]),
                      if (widget.userHistory.telephoneNumber != null)
                        DataRow(cells: [
                          DataCell(Text('Telephone Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.telephoneNumber,
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(widget.userHistory.telephoneNumber,
                              style: TextStyle(color: Colors.white))),
                        ]),
                      if (widget.userHistory.email != null)
                        DataRow(cells: [
                          DataCell(Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.email,
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(widget.userHistory.email,
                              style: TextStyle(color: Colors.white))),
                        ]),
                      if (widget.userHistory.title != null)
                        DataRow(cells: [
                          DataCell(Text('Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.title,
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(widget.userHistory.title,
                              style: TextStyle(color: Colors.white))),
                        ]),
                      if (widget.userHistory.probationary != null &&
                          widget.userHistory.probationary !=
                              widget.user.probationary)
                        DataRow(cells: [
                          DataCell(Text('Probationary?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                          DataCell(Text(widget.user.probationary ? 'Yes' : 'No',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(
                              widget.userHistory.probationary ? 'Yes' : 'No',
                              style: TextStyle(color: Colors.white))),
                        ]),
                    ],
                  ),
                ]),
              ),
      ),
    );
  }

  @override
  void dispose() {
    OrientationManager.portraitMode();
    super.dispose();
  }
}
//
// void displayHistory(
//     BuildContext context, User user, UserHistory userHistory) {
//   displayDialog(
//       context,
//       "Update History",
//       "Current value(s) and previous value(s) are displayed respectively\n\n"
//           "${userHistory.username == null ? '' : ('Username\n' + user.username + ' | ' + userHistory.username + '\n\n')}"
//           "${userHistory.fullName == null ? '' : ('Full name\n' + user.fullName + '\n' + userHistory.fullName + '\n\n')}"
//           "${userHistory.telephoneNumber == null ? '' : ('Telephone Number\n' + user.telephoneNumber + ' | ' + userHistory.telephoneNumber + '\n\n')}"
//           "${userHistory.email == null ? '' : ('Email\n' + user.email + '\n' + userHistory.email + '\n\n')}"
//           "${userHistory.title == null ? '' : ('Title\n' + user.title + ' | ' + userHistory.title + '\n\n')}"
//           "${userHistory.probationary == null ? '' : ('On Probationary : ' + (user.probationary ? 'Yes' : 'No') + ' | ' + (userHistory.probationary ? 'Yes' : 'No') + '\n\n')}");
// }
// }
