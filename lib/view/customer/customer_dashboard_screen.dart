import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/dashboard_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';
import 'package:timecapturesystem/view/customer/add_customer_screen.dart';
import 'package:timecapturesystem/view/customer/customer_card.dart';
import 'package:timecapturesystem/view/customer/customer_detail_page.dart';

class CustomerDashboard extends StatefulWidget {
  static const String id = "customer_dashboard";
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  CustomerService _customerService = CustomerService();
  List<Customer> _customerList;

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
              if (_customerList != null) {
                setState(() {
                  _customerList.removeRange(0, _customerList.length);
                });
              } else {
                setState(() {});
              }
            },
          ),
          HomeButton(),
        ],
      ),

      ///Body
      body: SafeArea(
        child: Column(
          children: [
            /// Dashboard title
            Text(
              "Customer Management Dashboard",
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

            ///add customer button
            DashBoardButton(
              icon: Icons.view_list_outlined,
              title: 'Add Customer',
              route: AddCustomerScreen.id,
              isIcon: false,
              height: 45,
            ),
            SizedBox(
              height: 10,
            ),

            ///customer list title
            Text(
              'Customer List',
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

            ///customer list builder
            FutureBuilder<dynamic>(
              future: _customerService.getAllCustomers(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;

                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text: "Customer data not available to show");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _customerList = snapshot.data;

                    child = ListView.builder(
                      itemCount: _customerList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: CustomerCard(
                            customer: _customerList[index],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerDetailPage(
                                  customer: _customerList[index],
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
