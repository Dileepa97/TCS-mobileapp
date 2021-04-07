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
import 'package:timecapturesystem/view/customer/customer_detail_page.dart';
import 'package:timecapturesystem/view/product/update_product_screen.dart';
import 'package:timecapturesystem/view/task/product_dashboard.dart';

class ProductDetailPage extends StatefulWidget {
  static const String id = 'product_details_page';

  final Product product;

  const ProductDetailPage({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _spin = false;
  bool _isCustomer = false;

  ShowAlertDialog _dialog = ShowAlertDialog();
  ProductService _productService = ProductService();
  Customer _customer;

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
          'Product Details',
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
                  ///Product name
                  Text(
                    widget.product.productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  DividerBox(),

                  ///product description
                  widget.product.productDescription != null &&
                          widget.product.productDescription.trim() != ''
                      ? Column(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.product.productDescription,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Source Sans Pro',
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            DividerBox(),
                          ],
                        )
                      : SizedBox(),

                  ///button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///update button ---------------------------------------------
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
                              return UpdateProductScreen(
                                product: widget.product,
                              );
                            }),
                          );
                        },
                      ),

                      ///delete button --------------------------------------------------
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
                            title: 'Delete Product!',
                            context: context,
                            children: [
                              Text(
                                  'Are you sure you want to permanently delete this Product? '),
                            ],

                            ///on pressed yes
                            onPressedYes: () async {
                              Navigator.of(context).pop();

                              dynamic res = await _productService
                                  .deleteProduct(widget.product.id);

                              ///deleted successfully
                              if (res == 200) {
                                _dialog.showAlertDialog(
                                  context: context,
                                  title: 'Deleted',
                                  body: 'Product successfully deleted.',
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
                                      'Cannot delete this product. \nTry again later',
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _spin = false;
                                    });
                                  },
                                );
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
                      )
                    ],
                  ),
                  DividerBox(),

                  ///customer list title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///text
                      Text(
                        'Product Customer List',
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
                          setState(() {
                            _isCustomer = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///customer list builder
                  Expanded(
                    child: widget.product.customerIdList.length != 0
                        ? ListView.builder(
                            itemCount: widget.product.customerIdList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: InputContainer(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      ///icon
                                      Icon(Icons.business_outlined),

                                      ///Customer name
                                      FutureBuilder(
                                        future: CustomerService.getCustomerById(
                                            widget
                                                .product.customerIdList[index]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          Widget child;

                                          if (snapshot.hasData) {
                                            if (snapshot.data == 1 ||
                                                snapshot.data == -1) {
                                              child = Text(
                                                'Cannot fetch data',
                                                style: TextStyle(
                                                  fontFamily: 'Source Sans Pro',
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              );
                                              _isCustomer = false;
                                            } else {
                                              _customer = snapshot.data;
                                              child = Text(
                                                _customer.organizationName,
                                                style: TextStyle(
                                                  fontFamily: 'Source Sans Pro',
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              );
                                              _isCustomer = true;
                                            }
                                          } else {
                                            child = Text(
                                              'Wait...',
                                              style: TextStyle(
                                                fontFamily: 'Source Sans Pro',
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            );
                                            _isCustomer = false;
                                          }

                                          return Expanded(child: child);
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                ///on tap
                                onTap: () {
                                  if (_isCustomer) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerDetailPage(
                                          customer: _customer,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          )
                        :

                        ///if customer not available
                        Center(
                            child: Text(
                              'No customers available for this product right now. You can add customers using \'Update\' product. ',
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
}
