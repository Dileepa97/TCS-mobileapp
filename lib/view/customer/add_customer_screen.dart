import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';

class AddCustomerScreen extends StatefulWidget {
  static const String id = "add_customer";
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  bool _spin = false;

  String _orgId;
  String _orgName;
  String _orgEmail;

  ShowAlertDialog _alertDialog = ShowAlertDialog();
  CustomerService _customerService = CustomerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'Add Customer',
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
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          ///customer form
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///form title
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Enter Customer Details',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.lightBlue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DividerBox(),

                ///Organization id
                InputContainer(
                  child: InputTextField(
                    labelText: 'Organization Id',
                    onChanged: (text) {
                      setState(() {
                        this._orgId = text;
                      });
                    },
                  ),
                ),

                ///Organization name
                InputContainer(
                  child: InputTextField(
                    labelText: 'Organization Name',
                    onChanged: (text) {
                      setState(() {
                        this._orgName = text;
                      });
                    },
                  ),
                ),

                ///email
                InputContainer(
                  child: InputTextField(
                    labelText: 'Email',
                    onChanged: (text) {
                      setState(() {
                        this._orgEmail = text;
                      });
                    },
                  ),
                ),

                ///button
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Submit',
                  minWidth: 200.0,
                  onPressed: () async {
                    if (_checkConditions()) {
                      setState(() {
                        _spin = true;
                      });

                      dynamic response = await _customerService.newCustomer(
                          this._orgId, this._orgName, this._orgEmail);

                      ///successful
                      if (response == 201) {
                        setState(() {
                          _spin = false;
                        });

                        this._alertDialog.showAlertDialog(
                              context: context,
                              title: 'Customer Added',
                              body: 'New customer added succesfully',
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                      }

                      ///server side error
                      else if (response == 1) {
                        setState(() {
                          _spin = false;
                        });

                        this._alertDialog.showAlertDialog(
                              context: context,
                              title: 'Error',
                              body:
                                  'Cannot add this customer. Check inserted data and try again later. ',
                              color: Colors.redAccent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                      }

                      ///error sending request
                      else {
                        setState(() {
                          _spin = false;
                        });

                        this._alertDialog.showAlertDialog(
                              context: context,
                              title: 'Error',
                              body:
                                  'There is an error. Please check your connection and try again later. ',
                              color: Colors.redAccent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkConditions() {
    ///if organization id missing
    if (this._orgId == null || this._orgId.trim() == '') {
      _alertDialog.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter organization id',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if organization name missing
    else if (this._orgName == null || this._orgName.trim() == '') {
      _alertDialog.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter organization name',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if organization email missing
    else if (this._orgEmail == null || this._orgEmail.trim() == '') {
      _alertDialog.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter organization email',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if email is not valid
    else if (!EmailValidator.validate(this._orgEmail)) {
      _alertDialog.showAlertDialog(
        title: 'Bad Input !',
        body: 'Email is not valid',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///if nothing missed
    return true;
  }
}
