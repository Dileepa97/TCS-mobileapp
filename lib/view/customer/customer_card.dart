import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/services/customer/customer_service.dart';
import 'package:timecapturesystem/view/customer/update_customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({
    Key key,
    this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowAlertDialog _dialog = ShowAlertDialog();
    CustomerService _customerService = CustomerService();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),

      ///card body
      child: Column(
        children: [
          ///organization name
          Text(
            customer.organizationName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Source Sans Pro',
              fontSize: 16,
            ),
          ),

          ///organization id
          Text(
            'Organization ID: ${customer.organizationID}  ',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 14,
              color: Colors.blueGrey,
            ),
          ),

          ///organization email
          Text(
            customer.email,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 14,
              color: Colors.blueGrey,
            ),
          ),

          DividerBox(),

          ///Button Row
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
                height: 30,

                ///onpressed update
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UpdateCustomerScreen(
                        customer: customer,
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
                height: 30,

                ///on pressed delete
                onPressed: () {
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

                        dynamic res =
                            await _customerService.deleteCustomer(customer.id);

                        ///deleted successfully
                        if (res == 200) {
                          _dialog.showAlertDialog(
                            context: context,
                            title: 'Deleted',
                            body: 'Product successfully deleted.',
                            color: Colors.blueAccent,
                            onPressed: () {
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
                            },
                          );
                        }
                      },

                      ///on pressed no
                      onPressedNo: () {
                        Navigator.of(context).pop();
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
