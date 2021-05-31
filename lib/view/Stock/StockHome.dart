import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/Item.dart';
import 'package:tandoorhutweb/services/itemService.dart';

class StockHome extends StatefulWidget {
  @override
  _StockHomeState createState() => _StockHomeState();
}

class _StockHomeState extends State<StockHome> {
  bool isveg;
  TextEditingController itemName = TextEditingController();
  TextEditingController price = TextEditingController();
  String type;
  String id;
  bool loading = false;

  delitem(String id) async {
    bool deleted = await ItemService.delteItem(id);
    if (deleted) {
      setState(() {
        itemList.removeWhere((element) => element.id == id);
      });
    }
  }

  itemTypeList(String type) {
    List<Item> tempItemList = itemList.where((element) {
      if (element.category == type)
        return true;
      else
        return false;
    }).toList();
    return Container(
      alignment: Alignment.center,
      height: 450,
      width: 300,
      child: ListView.builder(
        itemCount: tempItemList.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: Text(tempItemList[index].name),
            trailing: Text('Rs ' + tempItemList[index].price),
            leading: IconButton(
                icon: (Icon(Icons.cancel)),
                onPressed: () {
                  delitem(tempItemList[index].id);
                }),
          );
        },
      ),
    );
  }

  List<Item> itemList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    itemList = await ItemService.getAllItems();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 100,
                right: 100,
                top: 10,
                bottom: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Manage\nStock',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Divider(
                    indent: 05,
                    endIndent: 20,
                    height: 10,
                    thickness: 5,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            color: Color.fromRGBO(206, 206, 206, 1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 250,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: itemName,
                                          decoration: InputDecoration(
                                            focusColor: Colors.white,
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Item Name',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: DropdownButton(
                                          value: type,
                                          focusColor: Colors.white,
                                          hint: Text('Menu Type'),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Tandoor'),
                                              value: 'Tandoor',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Main Course'),
                                              value: 'Main Course',
                                            ),
                                            DropdownMenuItem(
                                              child:
                                                  Text('Chinese Main Course'),
                                              value: 'Chinese Main Course',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Rice/Biryani'),
                                              value: 'Rice/Biryani',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Noodles'),
                                              value: 'Noodles',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Rolls and Momos'),
                                              value: 'Rolls and Momos',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Salads & Raita'),
                                              value: 'Salads & Raita',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Breads'),
                                              value: 'Breads',
                                            ),
                                          ],
                                          onChanged: (value) {
                                            if (this.mounted) {
                                              setState(() {
                                                type = value.toString();
                                              });
                                            }
                                          },
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
                                          focusColor: Colors.white,
                                          value: isveg,
                                          hint: Text('Veg/Non Veg'),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Veg'),
                                              value: true,
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Non-Veg'),
                                              value: false,
                                            ),
                                          ],
                                          onChanged: (value) {
                                            if (this.mounted) {
                                              setState(() {
                                                isveg = value;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: price,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.money_off),
                                            focusColor: Colors.white,
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Price',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
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
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          var addedItem =
                                              await ItemService.createItem(
                                                  jsonEncode(Item(
                                            name: itemName.text,
                                            category: type,
                                            isVeg: isveg,
                                            photoUrl: "www.google.com",
                                            rating: "5.0",
                                            price: price.text,
                                          ).toJson()));
                                          setState(() {
                                            if (addedItem != false) {
                                              itemList.add(addedItem);
                                            }
                                            loading = false;
                                            itemName.clear();
                                            price.clear();
                                          });
                                        },
                                        child: Text(
                                          'Add Item',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        color: Colors.orange,
                                        padding: EdgeInsets.all(18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      loading
                                          ? CircularProgressIndicator()
                                          : Container(),
                                      Icon(Icons.local_dining, size: 100)
                                    ],
                                  ),
                                ),
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
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Tandoor',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Tandoor')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Main Course',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Main Course')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Chinese Main Course',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Chinese Main Course')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Rice/Biryani',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Rice/Biryani')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(50.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Noodles',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Noodles')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Breads',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Breads')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Rolls and Momos',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Rolls and Momos')
                                          ],
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 300,
                                              alignment: Alignment.center,
                                              color: Colors.orange[400],
                                              child: Text(
                                                'Salads & Raita',
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            itemTypeList('Salads & Raita')
                                          ],
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
    );
  }
}
