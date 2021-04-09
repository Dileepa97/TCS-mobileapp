import 'package:flutter/material.dart';

import 'package:timecapturesystem/models/customer/customer.dart';

class CustomerCard extends StatefulWidget {
  final Customer customer;

  const CustomerCard({
    Key key,
    this.customer,
  }) : super(key: key);

  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 60,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),

      ///card body
      child: Row(
        children: [
          ///icon
          CircleAvatar(
            child: Icon(Icons.business_outlined),
            radius: 20,
            foregroundColor: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),

          ///details
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Customer name
                  Text(
                    widget.customer.organizationName,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontFamily: 'Source Sans Pro',
                      fontSize: 18,
                    ),
                  ),

                  ///number of products
                  Text(
                    widget.customer.productIdList.length == 1
                        ? '${widget.customer.productIdList.length} product available'
                        : '${widget.customer.productIdList.length} products available',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
