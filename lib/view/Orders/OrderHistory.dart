import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:tandoorhutweb/services/orderService.dart';

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
  getNextData()async{
    setState(() {
      loading2 = true;
    });
    List<Order> tempList = await OrderService.getAllOrdersByCount(page, 15);
    setState(() {
      orderList.addAll(tempList);
      page+=15;
      loading2 = false;
    });
  }

  getData() async {
    setState(() {
      loading = true;
    });
    orderList = await OrderService.getAllOrdersByCount(page, 15);
    setState(() {
      page+=15;
      loading = false;
    });
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
                            itemCount: orderList.length+1,
                            itemBuilder: (context, index) {
                              return index == orderList.length ? Center(child: CircularProgressIndicator()):
                              Padding(
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
                                              // setState(() {
                                              //   orderList[index].status =
                                              //       "cancelled";
                                              // });
                                              // print(jsonEncode(
                                              //   orderList[index].toJson(),
                                              // ));
                                              // await OrderService.updateOrder(
                                              //   jsonEncode(
                                              //     orderList[index].toJson(),
                                              //   ),
                                              // );
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
                                              splashColor: Colors
                                                  .green, // inkwell color
                                              child: SizedBox(
                                                  width: 56,
                                                  height: 56,
                                                  child: Icon(
                                                    Icons.menu,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () {}),
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
