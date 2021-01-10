import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:intl/intl.dart';

class AbsentDayCard extends StatefulWidget {
  final NotAvailableUsers item;

  const AbsentDayCard({Key key, this.item}) : super(key: key);

  @override
  _AbsentDayCardState createState() => _AbsentDayCardState();
}

class _AbsentDayCardState extends State<AbsentDayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 90,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.today_outlined),
            radius: 20,
            foregroundColor: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(widget.item.date),
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20),
                  ),
                  Text(
                    DateFormat.EEEE().format(widget.item.date),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.item.users.length == 1
                        ? '${widget.item.users.length} user unavailable record'
                        : '${widget.item.users.length} user unavailable records',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
