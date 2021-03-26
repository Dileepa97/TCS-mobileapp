import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_card.dart';

import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:intl/intl.dart';

class AbsentUserDetailScreen extends StatefulWidget {
  final NotAvailableUsers item;

  const AbsentUserDetailScreen({Key key, this.item}) : super(key: key);
  @override
  _AbsentUserDetailScreenState createState() => _AbsentUserDetailScreenState();
}

class _AbsentUserDetailScreenState extends State<AbsentUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Colors.lightBlue.shade800,

      ///App Bar
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMMd().format(widget.item.date),
          style: TextStyle(
              // color: Colors.blue[800],
              fontFamily: 'Source Sans Pro',
              fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.item.users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: AbsentUserCard(userData: widget.item.users[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
