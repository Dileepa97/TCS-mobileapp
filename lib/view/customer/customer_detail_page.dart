import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';
import 'package:timecapturesystem/services/product/product_service.dart';
import 'package:timecapturesystem/view/customer/update_customer_screen.dart';
import 'package:timecapturesystem/view/product/product_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailPage extends StatefulWidget {
  static const String id = 'customer_details_page';

  final Customer customer;
  final bool disableLoadMore;

  const CustomerDetailPage({Key key, this.customer, this.disableLoadMore})
      : super(key: key);
  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  bool _spin = false;

  ShowAlertDialog _dialog = ShowAlertDialog();
  CustomerService _customerService = CustomerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///App Bar
      appBar: AppBar(
        leading: BackButton(
          color: Colors.lightBlue.shade800,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Customer Details',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            color: Colors.lightBlue.shade800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          HomeButton(
            color: Colors.lightBlue.shade800,
          ),
        ],
      ),

      ///body
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _spin,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ///organization name
                  Text(
                    widget.customer.organizationName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),

                  ///organization id
                  Text(
                    'Organization ID: ${widget.customer.organizationID}  ',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.blueGrey,
                    ),
                  ),

                  ///organization email
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white,
                      ),
                      child: Text(
                        'Email: ${widget.customer.email}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 16,
                        ),
                      ),
                    ),

                    ///onTap
                    onTap: () {
                      var subject = "";
                      var body = "Dear " + widget.customer.organizationName;
                      _launchUrl(
                          "mailto:${widget.customer.email}?subject=$subject&body=$body");
                    },
                  ),

                  DividerBox(),

                  ///Button Row
                  if (widget.disableLoadMore == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///update button -----------------------------------------
                        FlatButton(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blueAccent,

                          ///onpressed update
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return UpdateCustomerScreen(
                                  customer: widget.customer,
                                );
                              }),
                            );
                          },
                        ),

                        ///delete button -------------------------------------------
                        FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.redAccent,

                          ///on pressed delete
                          onPressed: () {
                            setState(() {
                              _spin = true;
                            });

                            _dialog.showConfirmationDialog(
                              title: 'Delete Customer!',
                              context: context,
                              children: [
                                Text(
                                    'Are you sure you want to permanently delete this Customer? '),
                              ],

                              ///on pressed yes
                              onPressedYes: () async {
                                Navigator.of(context).pop();

                                dynamic res = await _customerService
                                    .deleteCustomer(widget.customer.id);

                                if (this.mounted) {
                                  ///deleted successfully
                                  if (res == 200) {
                                    _dialog.showAlertDialog(
                                      context: context,
                                      title: 'Deleted',
                                      body: 'Customer successfully deleted.',
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
                                  }

                                  ///if error
                                  else {
                                    _dialog.showAlertDialog(
                                      context: context,
                                      title: 'Error occurred',
                                      body:
                                          'Cannot delete this Customer. \nTry again later',
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
                                Navigator.of(context).pop();
                                setState(() {
                                  _spin = false;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  if (widget.disableLoadMore == false) DividerBox(),

                  ///product list title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///text
                      Text(
                        'Customer Product List',
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                      ///refresh button
                      GestureDetector(
                        child: Icon(
                          Icons.refresh,
                          size: 22,
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///product list builder
                  Expanded(
                    child: widget.customer.productIdList.length != 0
                        ? ListView.builder(
                            itemCount: widget.customer.productIdList.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: ProductService.getProductById(
                                    widget.customer.productIdList[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  Widget child;

                                  if (snapshot.hasData) {
                                    ///if error
                                    if (snapshot.data == 1 ||
                                        snapshot.data == -1) {
                                      child = InputContainer(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            'Cannot fetch data',
                                            style: TextStyle(
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }

                                    ///if data arrive
                                    else {
                                      Product _product = snapshot.data;

                                      child = GestureDetector(
                                        child: InputContainer(
                                          height: 50,
                                          child: Row(
                                            children: [
                                              ///icon
                                              Icon(Icons.outbox),

                                              ///product name
                                              Expanded(
                                                child: Text(
                                                  _product.productName,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///on tap
                                        onTap: () {
                                          if (widget.disableLoadMore == false) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                  product: _product,
                                                  disableLoadMore: true,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    }
                                  }

                                  /// if data fetching
                                  else {
                                    child = InputContainer(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'Wait...',
                                          style: TextStyle(
                                            fontFamily: 'Source Sans Pro',
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }

                                  return child;
                                },
                              );
                            },
                          )
                        :

                        ///if customer not available
                        Center(
                            child: Text(
                              'No products available for this customer right now. ',
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
