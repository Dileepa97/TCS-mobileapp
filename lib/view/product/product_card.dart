import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/product/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 90,
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
            child: Icon(Icons.outbox),
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
                  ///product name
                  Text(
                    widget.product.productName,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                    ),
                  ),

                  ///number of customers
                  Text(
                    widget.product.customerIdList.length == 1
                        ? '${widget.product.customerIdList.length} customer'
                        : '${widget.product.customerIdList.length} customers',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                    ),
                  ),

                  ///number of tasks
                  Text(
                    // widget.item.users.length == 1
                    //     ? '${widget.item.users.length} user unavailable record'
                    //     : '${widget.item.users.length} user unavailable records',
                    'Number of tasks for this product',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
