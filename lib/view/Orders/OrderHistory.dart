import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:tandoorhutweb/services/orderService.dart';
import 'package:tandoorhutweb/services/pushService.dart';
import 'package:tandoorhutweb/view/Orders/OrderDetails.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with TickerProviderStateMixin {
  TabController _tabController;
  // ignore: unused_field
  int _index = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
    getData();
    getData2();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getNextData();
      }
    });
    _sc2.addListener(() {
      if (_sc2.position.pixels == _sc2.position.maxScrollExtent) {
        getNextData2();
      }
    });
  }

  bool loading = false;
  bool loading2 = false;
  bool loading22 = false;
  bool loading222 = false;
  List<Order> orderList = [];
  List<Order> orderList2 = [];
  int page = 0;
  int page2 = 0;
  ScrollController _sc = new ScrollController();
  ScrollController _sc2 = new ScrollController();
  getNextData() async {
    setState(() {
      loading2 = true;
    });
    List<Order> tempList =
        await OrderService.getAllUnconfirmedOrdersByCount(page, 15);
    setState(() {
      orderList.addAll(tempList);
      page += 15;
      loading2 = false;
    });
  }

  getData() async {
    setState(() {
      loading = true;
      orderList.clear();
    });
    orderList = await OrderService.getAllUnconfirmedOrdersByCount(page, 15);
    setState(() {
      page += 15;
      loading = false;
    });
  }

  getNextData2() async {
    setState(() {
      loading22 = true;
    });
    List<Order> tempList =
        await OrderService.getAllConfirmedOrdersByCount(page, 15);
    setState(() {
      orderList2.addAll(tempList);
      page2 += 15;
      loading22 = false;
    });
  }

  getData2() async {
    setState(() {
      loading222 = true;
      orderList2.clear();
    });
    orderList2 = await OrderService.getAllConfirmedOrdersByCount(page, 15);
    setState(() {
      page2 += 15;
      loading222 = false;
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
    _sc2.dispose();
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Order History",
                        style: TextStyle(fontSize: 32),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            page = 0;
                            page2 = 0;
                          });
                          getData();
                          getData2();
                        },
                        child: Icon(Icons.refresh),
                      )
                    ],
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Color(0xff314B8C), width: 4.0),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff314B8C),
                  ),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black.withOpacity(0.4),
                  labelColor: Color(0xff314B8C),
                  tabs: [
                    Tab(text: "Unconfirmed"),
                    Tab(text: "Confirmed"),
                  ],
                  onTap: (value) {
                    setState(() {
                      _index = value;
                    });
                    _tabController.animateTo(value,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 600));
                  },
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 7,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 175,
                        width: MediaQuery.of(context).size.width - 250,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              controller: _sc,
                              itemCount: orderList.length + 1,
                              itemBuilder: (context, index) {
                                return index == orderList.length
                                    ? Center(
                                        child: loading2
                                            ? CircularProgressIndicator()
                                            : Container(
                                              padding: EdgeInsets.all(16),
                                              child: Text("No Unconfirmed Orders"),
                                            ))
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
                                              Text("Rs. " +
                                                  (double.parse(orderList[index]
                                                              .amount) +
                                                          double.parse(
                                                              orderList[index]
                                                                  .gst))
                                                      .toString()),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Text(
                                                'Order Type: ',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                orderList[index].orderType,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Text('Status: '),
                                              DropdownButton(
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text("unconfirmed"),
                                                    value: "unconfirmed",
                                                  ),
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
                                                value: orderList[index].status,
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
                                                          onPressed: () async {
                                                            setState(
                                                              () {
                                                                orderList[index]
                                                                        .status =
                                                                    val;
                                                              },
                                                            );
                                                            await OrderService
                                                                .updateOrder(
                                                              jsonEncode(
                                                                orderList[index]
                                                                    .toJson(),
                                                              ),
                                                            );
                                                            orderList[index]
                                                                        .orderType !=
                                                                    "Billing"
                                                                ? await PushService.sendPushToUser(
                                                                    "Order Update",
                                                                    "Status of the order no : ${orderList[index].orderId} has been changed to ${orderList[index].status == "placed" ? "confirmed" :orderList[index].status }",
                                                                    orderList[
                                                                            index]
                                                                        .customer
                                                                        .deviceToken)
                                                                // ignore: unnecessary_statements
                                                                : () {
                                                                    print("ok");
                                                                  };
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          child: Text("No"),
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
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
                                                      ),
                                                    ),
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
                                                                      orderList[
                                                                          index],
                                                                ),
                                                              ),
                                                            );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              controller: _sc2,
                              itemCount: orderList2.length + 1,
                              itemBuilder: (context, index) {
                                return index == orderList2.length
                                    ? Center(
                                        child: loading22
                                            ? CircularProgressIndicator()
                                            : Container(
                                              padding: EdgeInsets.all(16),
                                                child: Text(
                                                    "No confirmed orders"),
                                              ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Order No: ' +
                                                      orderList2[index].orderId,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Order Time: ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  child: Text(
                                                    orderList2[index]
                                                        .createdAt
                                                        .toLocal()
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                  "Rs. " +
                                                      (double.parse(orderList2[
                                                                      index]
                                                                  .amount) +
                                                              double.parse(
                                                                orderList2[
                                                                        index]
                                                                    .gst,
                                                              ))
                                                          .toString(),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  'Order Type: ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  orderList2[index].orderType,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text('Status: '),
                                                DropdownButton(
                                                  items: [
                                                    DropdownMenuItem(
                                                      child:
                                                          Text("unconfirmed"),
                                                      value: "unconfirmed",
                                                    ),
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
                                                      orderList2[index].status,
                                                  onChanged: (val) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: Text(
                                                          "Do you want to status of Order no : ${orderList2[index].orderId} to $val ?",
                                                        ),
                                                        actions: [
                                                          MaterialButton(
                                                            child: Text("Yes"),
                                                            onPressed:
                                                                () async {
                                                              setState(
                                                                () {
                                                                  orderList2[
                                                                          index]
                                                                      .status = val;
                                                                },
                                                              );
                                                              await OrderService
                                                                  .updateOrder(
                                                                jsonEncode(
                                                                  orderList2[
                                                                          index]
                                                                      .toJson(),
                                                                ),
                                                              );
                                                              orderList2[index]
                                                                          .orderType !=
                                                                      "Billing"
                                                                  ? await PushService.sendPushToUser(
                                                                      "Order Update",
                                                                      "Status of the order no : ${orderList2[index].orderId} has been changed to ${orderList2[index].status}",
                                                                      orderList2[
                                                                              index]
                                                                          .customer
                                                                          .deviceToken)
                                                                  // ignore: unnecessary_statements
                                                                  : () {
                                                                      print(
                                                                          "ok");
                                                                    };
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
                                                        width: 42,
                                                        height: 42,
                                                        child: Icon(
                                                          Icons.menu,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        orderList2[index]
                                                                    .orderType ==
                                                                "Billing"
                                                            ? showdialog(
                                                                orderList2[
                                                                    index],
                                                              )
                                                            : Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OrderDetailsScreen(
                                                                    order: orderList2[
                                                                        index],
                                                                  ),
                                                                ),
                                                              );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
