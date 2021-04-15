import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/services/customer/customer_detail_availability_service.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';

class UpdateCustomerScreen extends StatefulWidget {
  static const String id = "update_customer";

  final Customer customer;

  const UpdateCustomerScreen({Key key, this.customer}) : super(key: key);

  @override
  _UpdateCustomerScreenState createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  bool _spin = false;

  String _orgId;
  String _orgName;
  String _orgEmail;

  String _orgIdNew = '';
  String _orgNameNew = '';
  String _orgEmailNew = '';

  ShowAlertDialog _alertDialog = ShowAlertDialog();
  CustomerService _customerService = CustomerService();

  @override
  void initState() {
    super.initState();
    _orgId = widget.customer.organizationID;
    _orgName = widget.customer.organizationName;
    _orgEmail = widget.customer.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'Update Customer',
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

          ///customer update form
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///form title
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Change $_orgName details',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.lightBlue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DividerBox(),

                ///Instruction
                Text(
                  'Note:',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    'Fill feilds that you only want to update. If you don\'t want to update any feild keep it blank or empty.',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.blueGrey,
                      fontSize: 15,
                    ),
                  ),
                ),
                DividerBox(),

                ///Organization id
                InputContainer(
                  child: InputTextField(
                    labelText: 'Organization Id',
                    onChanged: (text) {
                      setState(() {
                        this._orgIdNew = text;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      'Previous : $_orgId',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                ///Organization name
                InputContainer(
                  child: InputTextField(
                    labelText: 'Organization Name',
                    onChanged: (text) {
                      setState(() {
                        this._orgNameNew = text;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      'Previous : $_orgName',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                ///email
                InputContainer(
                  child: InputTextField(
                    labelText: 'Email',
                    onChanged: (text) {
                      setState(() {
                        this._orgEmailNew = text;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      'Previous : $_orgEmail',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                ///button
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Update',
                  minWidth: 200.0,
                  onPressed: () async {
                    setState(() {
                      _spin = true;
                    });

                    if (checkFields() &&
                        await _checkOrgId() &&
                        await _checkOrgName() &&
                        await _checkOrgEmail() &&
                        setValues()) {
                      dynamic response = await _customerService.updateCustomer(
                          widget.customer.id,
                          this._orgIdNew,
                          this._orgNameNew,
                          this._orgEmailNew);

                      if (this.mounted) {
                        ///successful
                        if (response == 200) {
                          setState(() {
                            _spin = false;
                          });

                          this._alertDialog.showAlertDialog(
                                context: context,
                                title: 'Customer Updated',
                                body: 'Customer updated succesfully!',
                                color: Colors.blueAccent,
                                onPressed: () {
                                  Navigator.pop(context);
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
                                    'Cannot update this customer. Check inserted data and try again later. ',
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
                    }

                    setState(() {
                      _orgIdNew = '';
                      _orgNameNew = '';
                      _orgEmailNew = '';
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool setValues() {
    if (this._orgIdNew == null || this._orgIdNew.trim() == '') {
      this._orgIdNew = this._orgId;
    }
    if (this._orgNameNew == null || this._orgNameNew.trim() == '') {
      this._orgNameNew = this._orgName;
    }
    if (this._orgEmailNew == null || this._orgEmailNew.trim() == '') {
      this._orgEmailNew = this._orgEmail;
    }

    ///if ok
    return true;
  }

  bool checkFields() {
    int unfilledCount = 0;

    ///set missing values as a previous values
    if (this._orgIdNew == null || this._orgIdNew.trim() == '') {
      unfilledCount++;
    }
    if (this._orgNameNew == null || this._orgNameNew.trim() == '') {
      unfilledCount++;
    }
    if (this._orgEmailNew == null || this._orgEmailNew.trim() == '') {
      unfilledCount++;
    }

    ///all unfilled
    if (unfilledCount == 3) {
      _alertDialog.showAlertDialog(
        title: 'No Input !',
        body:
            'You did not change any previous value. Please change fields you want and press again update button',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _spin = false;
          });
        },
      );
      return false;
    }

    ///validate email
    if (!EmailValidator.validate(this._orgEmailNew)) {
      _alertDialog.showAlertDialog(
        title: 'Bad Input !',
        body: 'New email is not valid',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _spin = false;
          });
        },
      );
      return false;
    }

    ///if ok
    return true;
  }

  Future<bool> _checkOrgId() async {
    dynamic res =
        await CustomerDetailAvailabilityService.checkOrgId(this._orgIdNew);

    if (this.mounted) {
      if (res == true) {
        ///if org Id exist

        _alertDialog.showAlertDialog(
          title: 'Bad Input !',
          body: 'This new organization id already exist. \nTry another id',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      } else if (res == false) {
        return true;
      } else {
        /// if any error occured

        _alertDialog.showAlertDialog(
          title: 'Error occured !',
          body:
              'Error occured while checking organization id is exist. \nTry again ',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      }
    }
    return false;
  }

  ///Check org name exist
  Future<bool> _checkOrgName() async {
    dynamic res =
        await CustomerDetailAvailabilityService.checkOrgName(this._orgNameNew);

    if (this.mounted) {
      if (res == true) {
        ///if org name exist

        _alertDialog.showAlertDialog(
          title: 'Bad Input !',
          body: 'This organization name already exist. \nTry another name',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      } else if (res == false) {
        return true;
      } else {
        /// if any error occured

        _alertDialog.showAlertDialog(
          title: 'Error occured !',
          body:
              'Error occured while checking organization name is exist. \nTry again ',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      }
    }
    return false;
  }

  ///Check org email exist
  Future<bool> _checkOrgEmail() async {
    dynamic res = await CustomerDetailAvailabilityService.checkOrgEmail(
        this._orgEmailNew);
    if (this.mounted) {
      if (res == true) {
        ///if org mail exist

        _alertDialog.showAlertDialog(
          title: 'Bad Input !',
          body: 'This organization email already exist. \nTry another email',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      } else if (res == false) {
        return true;
      } else {
        /// if any error occured

        _alertDialog.showAlertDialog(
          title: 'Error occured !',
          body:
              'Error occured while checking organization email is exist. \nTry again ',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _spin = false;
            });
          },
        );
        return false;
      }
    }
    return false;
  }
}
