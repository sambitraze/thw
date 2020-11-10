import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                statCrad(
                  "Total Orders",
                  100,
                ),
                statCrad(
                  "Total Sales  (Rs)",
                  100,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('BillList')
                          .orderBy("date", descending: true)
                          .limit(50)
                          .snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.amber,
                                  strokeWidth: 1),
                            );
                          default:
                            return ListView.builder(
                              itemCount: 50,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Text(
                                      'Order No: ' +
                                          snapshot.data.docs[index]['bill_no']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    title: Text('Delivery to'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(snapshot.data.docs[index]['total']
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
                                          child: Text('Status: ${stat(index)}'),
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
                                                  child: Icon(Icons.delete,color: Colors.white,)),
                                              onTap: () {},
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
                                                  child: Icon(Icons.menu,color: Colors.white,)),
                                              onTap: () {},
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
