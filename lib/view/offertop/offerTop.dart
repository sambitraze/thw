import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/Item.dart';
import 'package:tandoorhutweb/models/offers.dart';
import 'package:tandoorhutweb/models/top.dart';
import 'package:tandoorhutweb/services/itemService.dart';
import 'package:tandoorhutweb/services/offerService.dart';
import 'package:tandoorhutweb/services/topService.dart';

class OfferTop extends StatefulWidget {
  @override
  _OfferTopState createState() => _OfferTopState();
}

class _OfferTopState extends State<OfferTop> {
  bool loading = false;
  TextEditingController offerCode = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController maxLimit = TextEditingController();
  TextEditingController minLimit = TextEditingController();
  List<Offer> offerList = [];
  List<Top> top8List = [];
  List<Item> itemList = [];
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    items.clear();
    offerList = await OfferService.getOffers();
    var tempList = await TopService.getTops();
    itemList = await ItemService.getAllItems();
    top8List = [];
    itemList.forEach((element) {
      setState(() {
        items.add(DropdownMenuItem(
          child: Text(element.name),
          value: Top(item: element),
        ));
      });
    });
    for (int i = 0; i < 8; i++) {
      setState(() {
        top8List.add(Top(item: Item(name: null)));
      });
      tempList.forEach((element) {
        if (element.srl == (i + 1).toString()) {
          setState(() {
            top8List[i] = element;
          });
        }
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[250],
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 7,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 75,
                        width: MediaQuery.of(context).size.width / 2 - 100,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 28),
                              child: Text(
                                "Offer",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.grey[500],
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 148,
                              width:
                                  MediaQuery.of(context).size.width / 2 - 100,
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    color: Colors.grey[200],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        inputField(
                                          offerCode,
                                          "OfferCode",
                                          Icon(Icons.local_offer),
                                        ),
                                        inputField(
                                          percentage,
                                          "Percentage",
                                          Icon(Icons.confirmation_number),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            OfferService.createOffer(
                                              jsonEncode(
                                                {
                                                  "offerCode": offerCode.text,
                                                  "percentage": percentage.text,
                                                  // "minLimit": minLimit.text,
                                                  // "maxLimit": maxLimit.text,
                                                  "minLimit": "100",
                                                  "maxLimit": "1000",
                                                  "block": false
                                                },
                                              ),
                                            );
                                            getData();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          color: Colors.orange,
                                          minWidth: 100,
                                          height: 50,
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: 8),
                                  //   color: Colors.grey[200],
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       inputField(
                                  //         minLimit,
                                  //         "Min Limit",
                                  //         Icon(Icons.confirmation_number),
                                  //       ),
                                  //       inputField(
                                  //         maxLimit,
                                  //         "Max Limit",
                                  //         Icon(Icons.confirmation_number),
                                  //       ),
                                  //       MaterialButton(
                                  //         onPressed: () {
                                  //           OfferService.createOffer(
                                  //             jsonEncode(
                                  //               {
                                  //                 "offerCode": offerCode.text,
                                  //                 "percentage": percentage.text,
                                  //                 // "minLimit": minLimit.text,
                                  //                 // "maxLimit": maxLimit.text,
                                  //                 "minLimit": "100",
                                  //                 "maxLimit": "1000",
                                  //                 "block": false
                                  //               },
                                  //             ),
                                  //           );
                                  //         },
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(16)),
                                  //         color: Colors.orange,
                                  //         minWidth: 100,
                                  //         height: 50,
                                  //         child: Text(
                                  //           "Add",
                                  //           style: TextStyle(
                                  //               fontSize: 16,
                                  //               color: Colors.white),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "OfferCode",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "percentage",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Action",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        300,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            100,
                                    child: ListView.builder(
                                      itemCount: offerList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(offerList[index].offerCode),
                                              Text(offerList[index].percentage +
                                                  " %"),
                                              // Text(offerList[index].minLimit),
                                              // Text(offerList[index].maxLimit),
                                              Text(
                                                  "Status: ${offerList[index].block}"),
                                              MaterialButton(
                                                onPressed: () {
                                                  offerList[index].block =
                                                      !offerList[index].block;
                                                  OfferService.updateOffer(
                                                      jsonEncode(
                                                          offerList[index]
                                                              .toJson()));
                                                  getData();
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                color: Colors.orange,
                                                minWidth: 100,
                                                height: 40,
                                                child: Text(
                                                  offerList[index].block
                                                      ? "UnBlock"
                                                      : "Block",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 7,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 75,
                        width: MediaQuery.of(context).size.width / 2 - 100,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 28),
                              child: Text(
                                "Top 8",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.grey[500],
                            ),
                             Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Srl No",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Current",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "change",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Action",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                            Container(
                              height: MediaQuery.of(context).size.height - 240,
                              width:
                                  MediaQuery.of(context).size.width / 2 - 100,
                              child: ListView.builder(
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (index + 1).toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(top8List[index]
                                            .item
                                            .name
                                            .toString()),
                                        DropdownButton(
                                          // value: top8List[index],
                                          items: items,
                                          hint: Text("Change Item"),
                                          onChanged: (val) {
                                            setState(() {
                                              top8List[index] = val;
                                              top8List[index].srl =
                                                  (index + 1).toString();
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          onPressed: top8List[index].id == null
                                              ? () {
                                                  TopService.createTop(
                                                      jsonEncode(top8List[index]
                                                          .toJson()));
                                                  getData();
                                                }
                                              : () {
                                                  TopService.updateTop(
                                                      jsonEncode(top8List[index]
                                                          .toJson()));
                                                  getData();
                                                },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          color: Colors.orange,
                                          minWidth: 100,
                                          height: 50,
                                          child: Text(
                                            top8List[index].id == null
                                                ? "Add"
                                                : "Update",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  inputField(TextEditingController tc, hint, Icon icon) {
    return Container(
      height: 100,
      width: 200,
      alignment: Alignment.center,
      child: TextFormField(
        controller: tc,
        decoration: InputDecoration(
          prefixIcon: icon,
          focusColor: Colors.white,
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
      ),
    );
  }
}
