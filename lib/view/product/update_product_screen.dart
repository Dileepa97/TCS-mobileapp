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
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';
import 'package:timecapturesystem/services/product/product_detail_availability_service.dart';
import 'package:timecapturesystem/services/product/product_service.dart';

class UpdateProductScreen extends StatefulWidget {
  static const String id = "update_product";

  final Product product;

  const UpdateProductScreen({Key key, this.product}) : super(key: key);
  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool _spin = false;
  bool _isData = false;

  String _productName;
  String _description;
  List<String> _customerIdList;

  String _productNameNew;
  String _descriptionNew;

  ShowAlertDialog _alertDialog = ShowAlertDialog();
  CustomerService _customerService = CustomerService();
  ProductService _productService = ProductService();
  List<Customer> _customerList;

  @override
  void initState() {
    super.initState();
    _productName = widget.product.productName;
    _description = widget.product.productDescription;
    _customerIdList = widget.product.customerIdList;
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

      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          ///product update form
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///form title
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Change $_productName product details',
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

                ///Product name
                InputContainer(
                  child: InputTextField(
                    labelText: 'Product name',
                    onChanged: (text) {
                      setState(() {
                        this._productNameNew = text;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      'Previous : $_productName',
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

                ///Product description
                InputContainer(
                  child: InputTextField(
                    maxLines: null,
                    labelText: 'Product description',
                    onChanged: (text) {
                      setState(() {
                        this._descriptionNew = text;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      _description != null
                          ? 'Previous : $_description'
                          : 'Previous : No description',
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

                ///update customer list
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
                          value: _customerIdList,
                        )
                      : Center(
                          child: Text('Waiting for customers...'),
                        ),
                ),

                ///button
                RoundedButton(
                  color: Colors.blueAccent[200],
                  title: 'Update',
                  minWidth: 200.0,

                  ///on pressed
                  onPressed: () async {
                    setState(() {
                      _spin = true;
                    });

                    if (await _checkProductName() && setValues()) {
                      dynamic response = await _productService.updateProduct(
                          widget.product.id,
                          this._productNameNew,
                          this._descriptionNew,
                          this._customerIdList);

                      ///successful
                      if (response == 200) {
                        setState(() {
                          _spin = false;
                        });

                        this._alertDialog.showAlertDialog(
                              context: context,
                              title: 'Product Updated',
                              body: 'Product updated succesfully!',
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
                                  'Cannot update this product. try again later. ',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool setValues() {
    ///set missing values as a previous values
    if (this._productNameNew == null || this._productNameNew.trim() == '') {
      this._productNameNew = this._productName;
    }
    if (this._descriptionNew == null || this._descriptionNew.trim() == '') {
      this._descriptionNew = this._description;
    }

    return true;
  }

  ///Check product name exist
  Future<bool> _checkProductName() async {
    dynamic res = await ProductDetailAvailabilityService.checkProductName(
        this._productNameNew);

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
              'Error occured while checking product name is exist. \nTry again ',
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
