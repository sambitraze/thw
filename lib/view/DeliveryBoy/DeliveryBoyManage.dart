import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/deliveryBoy.dart';
import 'package:tandoorhutweb/services/deliveryBoyService.dart';

class DeliveryBoyManage extends StatefulWidget {
  @override
  _DeliveryBoyManageState createState() => _DeliveryBoyManageState();
  tileBox(title, trailing) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DeliveryBoyManageState extends State<DeliveryBoyManage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;
  List<Widget> nameList = [];
  List<Widget> phoneList = [];
  List<Widget> emailList = [];
  List<Widget> passwordList = [];
  List<Widget> blockedList = [];
  List<Widget> moreList = [];

  List<DeliveryBoy> deliveryBoyList = [];
  getData() async {
    setState(() {
      isLoading = true;
    });
    nameList.clear();
    phoneList.clear();
    emailList.clear();
    passwordList.clear();
    blockedList.clear();
    moreList.clear();
    deliveryBoyList = await DeliveryBoyService.getAllDeliveryBoy();
    moreList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    nameList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "Name",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    phoneList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "Phone",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    emailList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "Email",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    passwordList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "Password",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    blockedList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.orange,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Text(
              "Status",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    //
    deliveryBoyList.forEach((element) {
      moreList.add(TextButton(
        child: Icon(Icons.view_sidebar),
        onPressed: () {
          showDialog(
            context: context,
            // ignore: deprecated_member_use
            builder: (context)=> AlertDialog(
              backgroundColor: Colors.grey[200],
              title: Text("DeliveryBoy Detials"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.tileBox("Currently\nAssigned: ", element.assigned),
                  widget.tileBox("Total\nDeliverd: ", element.completed),
                  widget.tileBox("Total\nMonthly: ", element.monthly),
                  widget.tileBox("latitude: ", element.latitude),
                  widget.tileBox("longitude: ", element.longitude),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ok",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ));
      nameList.add(
        Text(
          element.name,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );
      phoneList.add(
        Text(
          element.phone,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );
      emailList.add(
        Text(
          element.email,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );
      blockedList.add(
        TextButton.icon(
          icon: element.blocked
              ? Icon(
                  Icons.block,
                  color: Colors.red,
                )
              : Icon(
                  Icons.block,
                  color: Colors.green,
                ),
          label: element.blocked
              ? Text(
                  "Unblock",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              : Text(
                  "Block",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
          onPressed: () async {
            setState(() {
              element.blocked = !element.blocked;
            });
            await DeliveryBoyService.updateDeliveryBoy(
              jsonEncode(
                element.toJson(),
              ),
            );
          },
        ),
      );
      passwordList.add(
        TextButton.icon(
          label: Text(
            element.password,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          icon: Icon(Icons.lock),
          onPressed: () {
            print(element.id);
            showDialog(
              context: context,
              // ignore: deprecated_member_use
              builder: (context)=> AlertDialog(
                backgroundColor: Colors.grey[200],
                title: Text("Change Password !!!"),
                content: inputField(
                  password,
                  "ENter New Password",
                  Icon(Icons.lock),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () async {
                      if (password.text.length >= 6) {
                        setState(
                          () {
                            element.password = password.text;
                          },
                        );
                        await DeliveryBoyService.updateDeliveryBoy(
                          jsonEncode(
                            element.toJson(),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password must be 6 or more character long'),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Change",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

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

  final scaffkey = new GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 20),
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
                        'Manage\nDelivery Boy',
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
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  inputField(name, "Name",
                                      Icon(Icons.person_add_outlined)),
                                  inputField(phone, "phone",
                                      Icon(Icons.phone_android_outlined)),
                                  MaterialButton(
                                    onPressed: () async {
                                      var random = new Random();
                                      if (name.text != null &&
                                          phone.text.length == 10) {
                                        setState(() {
                                          loading = true;
                                        });
                                        DeliveryBoy deliveryBoy =
                                            await DeliveryBoyService
                                                .createDeliveryBoy(
                                          jsonEncode(
                                            DeliveryBoy(
                                                    name: name.text,
                                                    email: random
                                                            .nextInt(1000)
                                                            .toString() +
                                                        "@tandoorhut.com",
                                                    phone: phone.text,
                                                    password: "123456")
                                                .toJson(),
                                          ),
                                        );
                                        if (deliveryBoy != null) {
                                          name.clear();
                                          phone.clear();
                                          setState(() {
                                            nameList.add(
                                              Text(
                                                deliveryBoy.name,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            );
                                            moreList.add(TextButton(
                                              child: Icon(Icons.view_sidebar),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  // ignore: deprecated_member_use
                                                  builder:(context)=> AlertDialog(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    title: Text(
                                                        "DeliveryBoy Detials"),
                                                    content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          widget.tileBox(
                                                              "Currently\nAssigned: ",
                                                              deliveryBoy
                                                                  .assigned),
                                                          widget.tileBox(
                                                              "Total\nDeliverd: ",
                                                              deliveryBoy
                                                                  .completed),
                                                          widget.tileBox(
                                                              "Total\nMonthly: ",
                                                              deliveryBoy
                                                                  .monthly),
                                                          widget.tileBox(
                                                              "latitude: ",
                                                              deliveryBoy
                                                                  .latitude),
                                                          widget.tileBox(
                                                              "longitude: ",
                                                              deliveryBoy
                                                                  .longitude),
                                                        ]),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Ok",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ));
                                            phoneList.add(
                                              Text(
                                                deliveryBoy.phone,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            );
                                            blockedList.add(
                                              TextButton.icon(
                                                icon: deliveryBoy.blocked
                                                    ? Icon(
                                                        Icons.block,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(
                                                        Icons.block,
                                                        color: Colors.green,
                                                      ),
                                                label: deliveryBoy.blocked
                                                    ? Text(
                                                        "Unblock",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                        ),
                                                      )
                                                    : Text(
                                                        "Block",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                onPressed: () async {
                                                  setState(() {
                                                    deliveryBoy.blocked =
                                                        !deliveryBoy.blocked;
                                                  });
                                                  await DeliveryBoyService
                                                      .updateDeliveryBoy(
                                                    jsonEncode(
                                                      deliveryBoy.toJson(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                            emailList.add(
                                              Text(
                                                deliveryBoy.email,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            );
                                            passwordList.add(
                                              TextButton.icon(
                                                label: Text(
                                                  deliveryBoy.password,
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                icon: Icon(Icons.lock),
                                                onPressed: () {
                                                  print(deliveryBoy.id);
                                                  showDialog(
                                                    context: context,
                                                    // ignore: deprecated_member_use
                                                    builder: (context)=> AlertDialog(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      title: Text(
                                                          "Change Password !!!"),
                                                      content: inputField(
                                                        password,
                                                        "ENter New Password",
                                                        Icon(Icons.lock),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        MaterialButton(
                                                          color: Colors.orange,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          onPressed: () {
                                                            if (password.text
                                                                    .length >=
                                                                6) {
                                                              setState(
                                                                () {
                                                                  deliveryBoy
                                                                          .password =
                                                                      password
                                                                          .text;
                                                                  DeliveryBoyService
                                                                      .updateDeliveryBoy(
                                                                    jsonEncode(
                                                                      deliveryBoy
                                                                          .toJson(),
                                                                    ),
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Password must be 6 or more character long'),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Change",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Delivery Boy Added was added'),
                                            ),
                                          );
                                        }
                                        setState(() {
                                          loading = false;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Fill details clearly'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Add User',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.orange,
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  loading
                                      ? CircularProgressIndicator()
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 400,
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: nameList,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: phoneList,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: emailList),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: passwordList,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: blockedList,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: moreList,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
