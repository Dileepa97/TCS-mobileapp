import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/dashboard_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/product/product_service.dart';
import 'package:timecapturesystem/view/product/add_product_screen.dart';
import 'package:timecapturesystem/view/product/product_card.dart';
import 'package:timecapturesystem/view/product/product_detail_page.dart';

class ProductManagementDashboard extends StatefulWidget {
  static const String id = "product_management_dashboard";
  @override
  _ProductManagementDashboardState createState() =>
      _ProductManagementDashboardState();
}

class _ProductManagementDashboardState
    extends State<ProductManagementDashboard> {
  ProductService _productService = ProductService();
  List<Product> _productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///App_bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_productList != null) {
                setState(() {
                  _productList.removeRange(0, _productList.length);
                });
              } else {
                setState(() {});
              }
            },
          ),
          HomeButton(),
        ],
      ),

      ///body
      body: SafeArea(
        child: Column(
          children: [
            /// Dashboard title
            Text(
              "Product Management Dashboard",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
              child: Divider(
                color: Colors.white,
              ),
            ),

            ///add product button
            DashBoardButton(
              icon: Icons.view_list_outlined,
              title: 'Add Product',
              route: AddProductScreen.id,
              isIcon: false,
              height: 45,
            ),
            SizedBox(
              height: 10,
            ),

            ///product list title
            Text(
              'Product List',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 17,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
              child: Divider(
                color: Colors.white,
              ),
            ),

            ///product list builder
            FutureBuilder<dynamic>(
              future: _productService.getAllProducts(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;

                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text: "Product data not available to show");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _productList = snapshot.data;

                    child = ListView.builder(
                      itemCount: _productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductCard(
                            product: _productList[index],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: _productList[index],
                                  disableLoadMore: false,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                } else {
                  child = LoadingText();
                }

                return Expanded(child: child);
              },
            ),
          ],
        ),
      ),
    );
  }
}
