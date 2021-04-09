import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/product/product_service.dart';
import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/task/product_dashboard.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class TaskPanel extends StatefulWidget {

  @override
  _TaskPanelState createState() => _TaskPanelState();
}

class _TaskPanelState extends State<TaskPanel> {

  List<Product> products;
  bool loading = true;

  getProducts(context) async{
    List<Product> productList = await ProductService().getAllProducts(context);
    setState(() {
      this.products = productList;
    });
  }

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getProducts(context);
      setState(() {
        Future.delayed(Duration(milliseconds: 1200),(){
          setState(() {
            this.loading = false;
          });
        });
      });
    }
  }

  Widget productCard(List<Product> products, BuildContext context) {

    List<Widget> productCardList = new List<Widget>();

    for(var i=0; i < 6 ; i++){
      productCardList.add(new InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductDashboard(product: products[i],)));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 80,
                  child: Container(
                      margin: EdgeInsets.all(25),
                      child: Text(
                        products[i].productName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),)),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                ),
                Container(
                  height: 40,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Number of tasks : 10"),
                        Text("Number of customers : "+products[i].customerIdList.length.toString())
                      ],
                    ),),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                ),
              ],
            ),
          )
      ));
    }

    return new Column(children: productCardList);

//    return InkWell(
//      onTap: () {
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => ProductDashboard()));
//      },
//      child: Container(
//        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: [
//            Container(
//              height: 80,
//              child: Container(
//                margin: EdgeInsets.all(25),
//                  child: Text(
//                    product.productName,
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20
//                    ),)),
//              decoration: BoxDecoration(
//                  color: Colors.blue.shade700,
//                  borderRadius: BorderRadius.only(
//                      topRight: Radius.circular(10),
//                      topLeft: Radius.circular(10))),
//            ),
//            Container(
//              height: 40,
//              child: Container(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: [
//                    Text("Number of tasks : 10"),
//                    Text("Number of customers : 3")
//                  ],
//                ),),
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.only(
//                      bottomRight: Radius.circular(10),
//                      bottomLeft: Radius.circular(10)),
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(0.5),
//                      spreadRadius: 2,
//                      blurRadius: 4,
//                      offset: Offset(0, 3), // changes position of shadow
//                    ),
//                  ]),
//            ),
//          ],
//        ),
//      )
//    );
  }

  @override
  Widget build(BuildContext context) {
    if(this.loading){
      return LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Product Dashboard", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: productCard(products, context),
//          child: Column(
//            children: [
//              SizedBox(height: 10,),
//              productCard(products,context),
//            ],
//          ),
        ),
      ),
    );
  }
}
