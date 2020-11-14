import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:tandoorhutweb/models/Item.dart';
import 'package:tandoorhutweb/models/cartItem.dart';
import 'package:tandoorhutweb/models/order.dart';
import 'package:tandoorhutweb/services/itemService.dart';
import 'package:tandoorhutweb/services/orderService.dart';
import 'package:tandoorhutweb/services/pdfService.dart';


class BillingHome extends StatefulWidget {
  @override
  _BillingHomeState createState() => _BillingHomeState();
}

class _BillingHomeState extends State<BillingHome> {
  String type;
  TextEditingController customer = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController quantity = TextEditingController();
  bool load = false;
  List<DropdownMenuItem> getItems = [];
  List<CartItem> cartItemList = [];
  List<CartItem> selectedCartItemList = [];

  double itemsum = 0;
  double packing = 0;
  double gstper = 0;
  double gstCharge = 0.0;
  double grandtot = 0.0;

  additemtotal() {
    itemsum = 0;
    gstCharge = 0.0;
    grandtot = 0.0;
    setState(() {
      cartItemList.forEach((element) {
        itemsum +=
            double.parse(element.item.price) * double.parse(element.count);
      });
      gstCharge = itemsum * gstper * 0.01;
      grandtot = gstCharge + itemsum;
    });
  }

  bool pageload = false;

  @override
  void initState() {
    super.initState();
    getData();
    // billColRef.doc('info').get().then(
    //   (value) {
    //     setState(() {
    //       billno = value['takeid'];
    //     });
    //   },
    // );
  }

  getData() async {
    setState(() {
      pageload = true;
    });
    List<Item> itemList = await ItemService.getAllItems();
    itemList.forEach((element) {
      getItems.add(DropdownMenuItem(
        child: Text(element.name),
        value: element,
      ));
    });
    setState(() {
      pageload = false;
    });
  }

  packDrop() {
    return DropdownButton(
      value: packing,
      hint: Text('Packing Charge'),
      items: [
        DropdownMenuItem(
          child: Text('packing: 0'),
          value: 0,
        ),
        DropdownMenuItem(
          child: Text('packing: 5'),
          value: 5,
        ),
        DropdownMenuItem(
          child: Text('packing: 10'),
          value: 10,
        ),
        DropdownMenuItem(
          child: Text('packing: 15'),
          value: 15,
        ),
        DropdownMenuItem(
          child: Text('packing: 20'),
          value: 20,
        )
      ],
      onChanged: (value) {
        setState(() {
          packing = value;
        });
      },
    );
  }

  List<DropdownMenuItem> gstList = List.generate(
      25,
      (index) => DropdownMenuItem(
            child: Text('GST ' + index.toString() + " %"),
            value: index,
          ));
  gstDrop() {
    return DropdownButton(
      value: gstper,
      hint: Text('Gst percentage'),
      items: gstList,
      onChanged: (value) {
        setState(() {
          gstper = value;
        });
      },
    );
  }

  onselectedRow(bool selected, CartItem billitem) async {
    setState(() {
      if (selected) {
        selectedCartItemList.add(billitem);
      } else {
        selectedCartItemList.remove(billitem);
      }
    });
  }

  deleteItems() async {
    setState(() {
      if (selectedCartItemList.isNotEmpty) {
        List<CartItem> temp = [];
        temp.addAll(selectedCartItemList);
        for (CartItem item in temp) {
          cartItemList.remove(item);
          selectedCartItemList.remove(item);
        }
      }
    });
  }

  genOrderNo() {
    var orderId = 
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString() +
        DateTime.now().millisecond.toString();
    return orderId;
  }

  Item tempItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageload
          ? CircularProgressIndicator()
          : Stack(
              children: [
                Container(
                  color: Colors.grey[100],
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 100, right: 100,bottom: 25,top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              width: 175,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Invoice',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 4,
                                    endIndent: 15,
                                    indent: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 230,
                                width: double.infinity,
                                color: Color.fromRGBO(206, 206, 206, 1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 200),
                                                child: packDrop(),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 200),
                                                child: gstDrop(),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 20),
                                            child: Icon(Icons.receipt, size: 75),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Near SBI ATM Godhna Road Ara, Bhojpur,\nPhone Number - 9852259112, 8340245998',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                            width: 400,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SearchableDropdown.single(
                                                items: getItems,
                                                value: itemName,
                                                hint: 'Search',
                                                searchHint: 'Search Item',
                                                onChanged: (value) {
                                                  print(value.name);
                                                  // setState(() {
                                                  //   itemName.text = value;
                                                  // });
                                                  setState(() {
                                                    tempItem = value;
                                                  });
                                                },
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: 200,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: quantity,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                focusColor: Colors.white,
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText: 'Quantity',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                cartItemList.add(CartItem(
                                                  item: tempItem,
                                                  count: quantity.text,
                                                ));
                                              });
                                              additemtotal();
                                              quantity.clear();
                                              itemName.clear();
                                            },
                                            child: Text(
                                              'Add',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            color: Colors.orange,
                                            padding: EdgeInsets.all(12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      padding: const EdgeInsets.all(50.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            elevation: 5,
                                            child: Container(
                                              color: Colors.white,
                                              child: DataTable(
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Text(
                                                      'Item',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Unit Price',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Quantity',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Amount',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                                rows: cartItemList
                                                    .map(
                                                      (cartitem) => DataRow(
                                                        onSelectChanged:
                                                            (selected) {
                                                          onselectedRow(
                                                              selected,
                                                              cartitem);
                                                        },
                                                        selected:
                                                            selectedCartItemList
                                                                .contains(
                                                                    cartitem),
                                                        cells: [
                                                          // DataCell(Text(billitem.srlNo
                                                          //     .toString())),
                                                          DataCell(Text(cartitem
                                                              .item.name
                                                              .toString())),
                                                          DataCell(Text(cartitem
                                                              .item.price
                                                              .toString())),
                                                          DataCell(Text(cartitem
                                                              .count
                                                              .toString())),
                                                          DataCell(
                                                            Text(
                                                              (double.parse(cartitem
                                                                          .item
                                                                          .price) *
                                                                      double.parse(
                                                                          cartitem
                                                                              .count))
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            elevation: 5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 400,
                                                  alignment: Alignment.center,
                                                  color: Colors.orange[400],
                                                  child: Text(
                                                    'Total Amount',
                                                    style: TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  height: 300,
                                                  width: 350,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading:
                                                            Text('Item Total'),
                                                        trailing: Text('Rs ' +
                                                            itemsum.toString()),
                                                      ),
                                                      ListTile(
                                                        leading:
                                                            Text('Packaging'),
                                                        trailing: Text('Rs ' +
                                                            packing.toString()),
                                                      ),
                                                      ListTile(
                                                        leading: Text('GST @ ' +
                                                            gstper.toString()),
                                                        trailing: Text('Rs ' +
                                                            gstCharge
                                                                .toStringAsFixed(
                                                                    2)),
                                                      ),
                                                      ListTile(
                                                        leading:
                                                            Text('Grand Total'),
                                                        trailing: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          child: Text('Rs ' +
                                                              (packing +
                                                                      grandtot)
                                                                  .toStringAsFixed(
                                                                      2)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            onPressed:
                                                selectedCartItemList.isEmpty
                                                    ? null
                                                    : () {
                                                        deleteItems();
                                                        additemtotal();
                                                      },
                                            child: Text(
                                              'Delete Item',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            color: Colors.orange,
                                            padding: EdgeInsets.all(18),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: 250,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: customer,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.person),
                                                focusColor: Colors.white,
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText: 'Customer Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: 250,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: phoneNo,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.phone),
                                                focusColor: Colors.white,
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText: 'Phone Number',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            padding: EdgeInsets.all(8),
                                            width: 200,
                                            alignment: Alignment.center,
                                            child: DropdownButton(
                                              value: type,
                                              focusColor: Colors.white,
                                              hint: Text('Payment Type'),
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text('Cash'),
                                                  value: 'Cash',
                                                ),
                                                // DropdownMenuItem(
                                                //   child: Text('UPI'),
                                                //   value: 'UPI',
                                                // ),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  type = value;
                                                });
                                              },
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              setState(() {
                                                load = true;
                                              });
                                              load
                                                  ? showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18)),
                                                        title:
                                                            Text('Proccesing'),
                                                        content: Container(
                                                          height: 100,
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        35),
                                                            child:
                                                                LinearProgressIndicator(),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Text('');
                                              var payload = Order(
                                                      items: cartItemList,
                                                      orderId: genOrderNo(),
                                                      custName: customer.text
                                                          .toString(),
                                                      custNumber: phoneNo.text
                                                          .toString(),
                                                      paymentType: "Cash",
                                                      orderType: "Billing",
                                                      status: "placed",
                                                      amount:
                                                          itemsum.toString(),
                                                      packing:
                                                          packing.toString(),
                                                      gst: gstCharge.toString(),
                                                      date:  (DateTime.now().day.toString() + '-' + DateTime.now().month.toString() + '-' + DateTime.now().year.toString()).toString(),
                                                      gstRate:
                                                          gstper.toString(),
                                                      paid: true)
                                                  .toJson();
                                              bool ordered = await OrderService
                                                  .createOrder(
                                                jsonEncode(payload),
                                              );
                                              if (ordered) {
                                                setState(() {
                                                  load = false;
                                                });
                                              }
                                              Uint8List pdfBytes =
                                                  await PdfService.createPdf(
                                                      jsonEncode(payload));
                                              await Printing.layoutPdf(
                                                  onLayout: (_) => pdfBytes);

                                              Navigator.of(context).pop();
                                              setState(() {
                                                cartItemList.clear();
                                              customer.clear();
                                              phoneNo.clear();
                                              selectedCartItemList.clear();
                                              });
                                            },
                                            child: Text(
                                              'Print Bill',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            color: Colors.orange,
                                            padding: EdgeInsets.all(18),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
