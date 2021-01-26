import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:tandoorhutweb/services/orderService.dart';
import 'package:tandoorhutweb/view/Orders/OrderDetails.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
    getData();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getNextData();
      }
    });
  }

  bool loading = false;
  bool loading2 = false;
  List<Order> orderList = [];
  int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  getNextData() async {
    setState(() {
      loading2 = true;
    });
    List<Order> tempList = await OrderService.getAllOrdersByCount(page, 15);
    setState(() {
      orderList.addAll(tempList);
      page += 15;
      loading2 = false;
    });
  }

  getData() async {
    setState(() {
      loading = true;
    });
    orderList = await OrderService.getAllOrdersByCount(page, 15);
    setState(() {
      page += 15;
      loading = false;
    });
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
  void dispose() {
    _sc.dispose();
    super.dispose();
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
                    "Order History",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 7,
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height - 150,
                          width: MediaQuery.of(context).size.width - 300,
                          child: ListView.builder(
                            controller: _sc,
                            itemCount: orderList.length + 1,
                            itemBuilder: (context, index) {
                              return index == orderList.length
                                  ? Center(
                                      child: loading2
                                          ? CircularProgressIndicator()
                                          : Container())
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Text(
                                          'Order No: ' +
                                              orderList[index].orderId,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // title: Text('Delivery to'),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text((double.parse(orderList[index]
                                                        .amount) +
                                                    double.parse(
                                                        orderList[index].gst) +
                                                    double.parse(
                                                        orderList[index]
                                                            .packing))
                                                .toString()),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Row(
                                              children: [
                                                Text('Status: '),
                                                DropdownButton(
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text("placed"),
                                                      value: "placed",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text(
                                                          "out for delivery"),
                                                      value: "out for delivery",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("cooking"),
                                                      value: "cooking",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("completed"),
                                                      value: "completed",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("cancelled"),
                                                      value: "cancelled",
                                                    ),
                                                  ],
                                                  value:
                                                      orderList[index].status,
                                                  onChanged: (val) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: Text(
                                                            "Do you want to status of Order no : ${orderList[index].orderId} to $val ?"),
                                                        actions: [
                                                          MaterialButton(
                                                            child: Text("Yes"),
                                                            onPressed:
                                                                () async {
                                                              setState(
                                                                () {
                                                                  orderList[
                                                                          index]
                                                                      .status = val;
                                                                },
                                                              );
                                                              await OrderService
                                                                  .updateOrder(
                                                                jsonEncode(
                                                                  orderList[
                                                                          index]
                                                                      .toJson(),
                                                                ),
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          MaterialButton(
                                                            child: Text("No"),
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            ClipOval(
                                              child: Material(
                                                color: Colors
                                                    .black, // button color
                                                child: InkWell(
                                                    splashColor: Colors
                                                        .green, // inkwell color
                                                    child: SizedBox(
                                                        width: 56,
                                                        height: 56,
                                                        child: Icon(
                                                          Icons.menu,
                                                          color: Colors.white,
                                                        )),
                                                    onTap: () {
                                                      orderList[index]
                                                                  .orderType ==
                                                              "Billing"
                                                          ? showdialog(
                                                              orderList[index])
                                                          : Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OrderDetailsScreen(
                                                                            order:
                                                                                orderList[index],
                                                                          )));
                                                    }),
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
                )
              ],
            ),
          );
  }
}
