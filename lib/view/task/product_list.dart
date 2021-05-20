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
  ProductService _productService = ProductService();
  int length = 0;

  getProducts(context) async{
    await _productService.getAllProducts(context).then((value) => {
      setState(() {
        this.products = value;
        this.loading = false;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    if(this.loading) {
      this.getProducts(context);
    }
  }

  void warningMessage(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('No customers found!',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600,
              color: Colors.red
            ),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text('Contact admin',
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.grey.shade600
                  ),
                ),
                SizedBox(height: 20,),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: Colors.redAccent,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                SizedBox(height: 20,),
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                    child: Text("Okay",
                      style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white
                      ),
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget productCard(List<Product> products, BuildContext context){

    List<Widget> productCardList = new List<Widget>();

    for(var i=0; i < products.length ; i++){
      productCardList.add(new InkWell(
          onTap: () {
            if(products[i].customerIdList != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDashboard(product: products[i],)));
            }else{
              this.warningMessage(context);
            }
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
                            fontSize: 20,
                          fontFamily: 'Arial',
                        ),)),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
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
                        Text((() {
                          if(products[i].taskCount == null){
                            return "Number of tasks : 0";
                          }
                            return "Number of tasks : "+products[i].taskCount.toString();
                        })(),style: TextStyle(fontFamily: 'Arial',)),
                        Text((() {
                          if(products[i].customerIdList == null){
                            return "Number of customers : 0";
                          }
                          return "Number of customers : "+products[i].customerIdList.length.toString();
                        })(),style: TextStyle(fontFamily: 'Arial',)),
                      ],
                    ),
                  ),
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

  }

  @override
  Widget build(BuildContext context) {

    if(this.loading){
      return LoadingScreen();
    }
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title:
            Text("Product List", style: TextStyle(color: Colors.white, fontFamily: 'Arial',)),
        backgroundColor: Colors.lightBlue.shade800,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: productCard(products, context),
        ),
      ),
    );
  }
}
