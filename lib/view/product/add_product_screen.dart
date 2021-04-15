import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smart_select/smart_select.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';
import 'package:timecapturesystem/services/product/product_detail_availability_service.dart';
import 'package:timecapturesystem/services/product/product_service.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = "add_product";
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool _spin = false;
  bool _isData = false;

  String _productName;
  String _description;
  List<String> _customerIdList;

  ShowAlertDialog _alertDialog = ShowAlertDialog();
  CustomerService _customerService = CustomerService();
  ProductService _productService = ProductService();
  List<Customer> _customerList;

  @override
  void initState() {
    super.initState();
    getIdList();
  }

  ///get customer list
  void getIdList() async {
    dynamic res = await _customerService.getAllCustomers(context);

    if (res == 204 || res == 1 || res == -1) {
      return;
    } else {
      _customerList = res;

      setState(() {
        _isData = true;
      });
    }
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
          'Add Product',
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

          ///product form
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///form title
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Enter Product Details',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.lightBlue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DividerBox(),

                ///Product name
                InputContainer(
                  child: InputTextField(
                    labelText: 'Product name*',
                    onChanged: (text) {
                      setState(() {
                        this._productName = text;
                      });
                    },
                  ),
                ),

                ///Product description
                InputContainer(
                  child: InputTextField(
                    maxLines: null,
                    labelText: 'Product description (optional)',
                    onChanged: (text) {
                      setState(() {
                        this._description = text;
                      });
                    },
                  ),
                ),

                ///Select customers
                InputContainer(
                  height: 70,
                  child: _isData
                      ? SmartSelect<String>.multiple(
                          title: 'Custormers',
                          modalTitle: 'Select customers',
                          placeholder: 'Choose one or more',
                          modalHeaderStyle: S2ModalHeaderStyle(
                            textStyle: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                          ),
                          choiceStyle: S2ChoiceStyle(
                            color: Colors.blueGrey,
                            titleStyle: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 17,
                            ),
                          ),
                          onChange: (selected) {
                            setState(() => _customerIdList = selected.value);
                          },
                          choiceItems: S2Choice.listFrom<String, Customer>(
                            source: _customerList,
                            title: (index, item) => item.organizationName,
                            value: (index, item) => item.id,
                          ),
                          choiceGrouped: false,
                          modalType: S2ModalType.popupDialog,
                          modalFilter: true,
                          tileBuilder: (context, state) {
                            return S2Tile.fromState(
                              state,
                              isTwoLine: true,
                            );
                          },
                          value: [],
                        )
                      : Center(
                          child: Text('Waiting for customers...'),
                        ),
                ),

                ///button
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Submit',
                  minWidth: 200.0,

                  ///on pressed
                  onPressed: () async {
                    if (_checkConditions() && await _checkProductName()) {
                      setState(() {
                        _spin = true;
                      });

                      dynamic response = await _productService.newProduct(
                          this._productName,
                          this._description,
                          this._customerIdList);

                      if (this.mounted) {
                        ///successful
                        if (response == 201) {
                          setState(() {
                            _spin = false;
                          });

                          this._alertDialog.showAlertDialog(
                                context: context,
                                title: 'Product Added',
                                body: 'New product added succesfully',
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
                                    'Cannot add this product. Check inserted data and try again later. ',
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///check inputs
  bool _checkConditions() {
    ///if product name missing
    if (this._productName == null || this._productName.trim() == '') {
      _alertDialog.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter product name',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    }

    ///is ok
    return true;
  }

  ///Check product name exist
  Future<bool> _checkProductName() async {
    dynamic res = await ProductDetailAvailabilityService.checkProductName(
        this._productName);

    if (this.mounted) {
      if (res == true) {
        ///if product name exist

        _alertDialog.showAlertDialog(
          title: 'Bad Input !',
          body: 'This product name already exist. \nTry another name',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
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
              'Error occured while checking product name is exist. \nTry again ',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return false;
      }
    }
    return false;
  }
}
