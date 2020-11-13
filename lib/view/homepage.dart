import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tandoorhutweb/models/Item.dart';
import 'package:tandoorhutweb/view/Auth/LoginScreen.dart';
import 'package:tandoorhutweb/view/Billing/BillingHome.dart';
import 'package:tandoorhutweb/view/DashBoard/DashboardHome.dart';
import 'package:tandoorhutweb/view/Stock/StockHome.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;
  PageController pageController;
  bool islaoding = true;
  final billColRef = FirebaseFirestore.instance.collection('BillList');
final menuItemColRef = FirebaseFirestore.instance.collection('MenuItems');
  QuerySnapshot billsnapshot;

  @override
  void initState() {
    pageController = PageController(
      initialPage: 2,
      keepPage: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
        children: [
          NavigationRail(
            elevation: 3,
            backgroundColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Colors.black, size: 35),
            unselectedIconTheme:
                IconThemeData(color: Colors.grey[700], size: 35),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(
                () {
                  _selectedIndex = index;
                },
              );
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 600),
                curve: Curves.ease,
              );
            },
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'), radius: 30),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height - 400),
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool("login", false);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ),
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard),
                label: Text(
                  'DashBoard',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.folder_open),
              //   selectedIcon: Icon(Icons.folder_open),
              //   label: Text(
              //     'Orders',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              NavigationRailDestination(
                icon: Icon(Icons.store),
                selectedIcon: Icon(Icons.store),
                label: Text(
                  'Manage Stock',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.shopping_cart),
              //   selectedIcon: Icon(Icons.shopping_cart),
              //   label: Text(
              //     'Staff',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt),
                selectedIcon: Icon(Icons.receipt),
                label: Text(
                  'Bill Maker',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              physics: new NeverScrollableScrollPhysics(),
              children: [
                // DashBoard(),
                // Orders(),
                // Messages(),
                // ManageMenu(),
                // Staffpage(),
                // Billing(),
                DashBoardHome(),
                StockHome(),
                BillingHome(),
              ],
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
