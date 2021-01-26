
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;
  OrderDetailsScreen({this.order});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Order order;
  bool isVisible = false;
  bool isVisible1 = false;
  GlobalKey<ScaffoldState> scaffkey = new GlobalKey();
  String newRating;

  List<Widget> srlNo = [
    Text(
      'Sl No.',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> itemName = [
    Text(
      'Item Name',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> quantity = [
    Text(
      'Quantity',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> price = [
    Text(
      'Price',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  //Fields
  String status = '';

  @override
  void initState() {
    super.initState();
    order = widget.order;
    isVisible = getStatus();
    isVisible1 = getstatus1();
    genList();
  }

  genList() {
    int i = 0;
    order.items.forEach((element) {
      setState(() {
        srlNo.add(
          Text(
            (i + 1).toString() + ".",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        itemName.add(
          Text(
            element.item.name,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        quantity.add(
          Text(
            'x' + element.count,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        price.add(
          Text(
            '₹' + element.item.price.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        i++;
      });
    });
  }

  getstatus1() {
    if (order.status == 'Placed' || order.status == "Received")
      return true;
    else
      return false;
  }

  getStatus() {
    if (order.status == 'Out for Delivery')
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Order Details',
          style: TextStyle(
              color: Color(0xff25354E),
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        centerTitle: true,
        
        iconTheme: IconThemeData(
          color: Color(0xff25354E), //change your color here
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text('#${order.orderId}',
                      style: TextStyle(
                          color: Color(0xff25354E),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text(
                    '${DateFormat("yy-MM-dd HH:mm:SSS").parse(order.createdAt.toString(), true).toLocal()}',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),                
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Deliver to",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    '${order.custName} ${order.custNumber}, \n${order.customer.address}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffD9F5F8),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                          child: Text(
                            'ITEMS',
                            style: TextStyle(
                              color: Color(0xff25354E),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: srlNo),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: itemName),
                                Column(children: quantity),
                                Column(children: price),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item total: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff25354E),
                          ),
                        ),
                      ),
                      Text(
                        '₹ ${order.amount}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff25354E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Charges: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff25354E),
                          ),
                        ),
                      ),
                      Text('₹ ${double.parse(order.amount).toStringAsFixed(2)}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff25354E),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item deduction: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff25354E),
                          ),
                        ),
                      ),
                      // Text(
                      //   '- ₹ ${double.parse(order.deduction.numberDecimal).toStringAsFixed(2)}',
                      //   textAlign: TextAlign.left,
                      //   style: GoogleFonts.lato(
                      //     textStyle: TextStyle(
                      //       fontSize: 17,
                      //       fontWeight: FontWeight.w600,
                      //       color: Color(0xff25354E),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total: ',
                          style: TextStyle(
                            color: Color(0xff25354E),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          '₹ ${(double.parse(order.amount) - double.parse(order.gst)).toStringAsFixed(2) }',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff25354E),
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Method: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff25354E),
                            ),
                          )),
                      Text('${order.paymentType}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff25354E),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Status: ',
                          style: GoogleFonts.lato(
                            textStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff25354E),
                              ),
                            ),
                          )),
                      Text('${order.status}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff25354E),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(height: 16),
                ListTile(                  
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Delivery By",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    '${order.deliveryby.name}\nPh: ${order.deliveryby.phone}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget cancelOrder(context) {
    return Visibility(
      visible: isVisible1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Delete Order!!!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("\nDo you want to delete order"),
                  ],
                ),
                actionsPadding: EdgeInsets.only(right: 15, bottom: 5),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff25354E),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: Color(0xff25354E),
                    onPressed: () async {
                      // Navigator.of(context).pop();
                      // await OrderService.updateStatus(order.id,
                      //     jsonEncode({"status": "Cancelled", "_id": order.id}));
                      // await updateStock(order.products);
                      // DeliveryBoy boy = await DeliveryService.getDeliveryBoy(
                      //     order.deliveryBy.id);
                      // await DeliveryService.updateDeliveryData(boy.id,
                      //     (int.parse(boy.assignedOrder) - 1).toString());
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (BuildContext context) => Home()),
                      //   ModalRoute.withName('/'),
                      // );
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.delete_forever,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget trackButton(context) {
    return Visibility(
      visible: isVisible,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        onPressed: () async {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => MapScreen(
          //       id: order.deliveryBy.id,
          //     ),
          //   ),
          // );
        },
        child: Icon(
          Icons.my_location,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
