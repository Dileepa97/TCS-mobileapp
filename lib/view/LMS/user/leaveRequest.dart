import 'package:flutter/material.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final _formKey = GlobalKey<FormState>();
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Request',
        ),
      ),
      //backgroundColor: Colors.blueAccent[100],
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter user id*',
                  icon: Icon(
                    Icons.person,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              child: Text(
                'Start date',
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021))
                    .then((date) {
                  setState(() {
                    startDate = date;
                  });
                });
              },
            ),
            Text(startDate == null ? 'Leave Start Date' : '$startDate'),
            RaisedButton(
              child: Text(
                'End date',
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021))
                    .then((date) {
                  setState(() {
                    endDate = date;
                  });
                });
              },
            ),
            Text(startDate == null ? 'Leave End Date' : '$endDate'),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {}
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
