import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:tandoorhutweb/services/orderService.dart';
import 'package:tandoorhutweb/view/DashBoard/StatCard.dart';

class DashBoardHome extends StatefulWidget {
  @override
  _DashBoardHomeState createState() => _DashBoardHomeState();
}

class _DashBoardHomeState extends State<DashBoardHome> {
  stat(int a) {
    if (a == 0)
      return "placed";
    else if (a > 0 && a < 10)
      return "Confirmed";
    else
      return "Out for";
  }

  List<Order> orderList = [];

  bool loading = true;
  double ordersum = 0.0;

  getData() async {
    ordersum = 0.0;
    orderList = await OrderService.getAllOrders();
    setState(() {
      orderList.forEach((element) {
        ordersum += double.parse(element.amount) +
            double.parse(element.gst) +
            double.parse(element.packing);
      });
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void showdialog(Order order) {
    var itemlists = "";
    order.items.forEach((e) {
      itemlists += "${e.item.name}" + " x " + "${e.count}" + "\t";
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Order Data"),
            content: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bill No: ${order.orderId}"),
                  Text("Items: $itemlists"),
                  Text(
                      "Total: ${double.parse(order.amount) + double.parse(order.packing) + double.parse(order.gst)}"),
                  Text("paid: ${order.paid}"),
                  Text("Status: ${order.status}"),
                  Text("Billed To: ${order.custName}"),
                  Text("Phone No: ${order.custNumber}"),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[250],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 100, top: 30, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "DashBoard",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      statCrad(
                        "Total Orders",
                        orderList.length,
                      ),
                      statCrad(
                        "Total Sales  (Rs)",
                        ordersum,
                      ),
                      statCrad(
                        "Total Users",
                        100,
                      ),
                      statCrad(
                        "Total Staff",
                        100,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 7,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 350,
                    width: MediaQuery.of(context).size.width - 300,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 12.0, left: 28),
                          child: Text(
                            "Recent Orders",
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height - 420,
                            width: MediaQuery.of(context).size.width - 300,
                            child: ListView.builder(
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Text(
                                      'Order No: ' + orderList[index].orderId,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // title: Text('Delivery to'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text((double.parse(
                                                    orderList[index].amount) +
                                                double.parse(
                                                    orderList[index].gst) +
                                                double.parse(
                                                    orderList[index].packing))
                                            .toString()),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        MaterialButton(
                                          minWidth: 300,
                                          onPressed: () {},
                                          child: Text(
                                              'Status: ${orderList[index].status}'),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.red, // button color
                                            child: InkWell(
                                              splashColor:
                                                  Colors.blue, // inkwell color
                                              child: SizedBox(
                                                  width: 56,
                                                  height: 56,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () async {
                                                setState(() {
                                                  orderList[index].status =
                                                      "cancelled";
                                                });
                                                print(jsonEncode(
                                                  orderList[index].toJson(),
                                                ));
                                                await OrderService.updateOrder(
                                                  jsonEncode(
                                                    orderList[index].toJson(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.black, // button color
                                            child: InkWell(
                                              splashColor:
                                                  Colors.green, // inkwell color
                                              child: SizedBox(
                                                  width: 56,
                                                  height: 56,
                                                  child: Icon(
                                                    Icons.menu,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () =>
                                                  showdialog(orderList[index]),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
