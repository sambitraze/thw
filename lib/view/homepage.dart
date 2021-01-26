import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tandoorhutweb/view/Auth/LoginScreen.dart';
import 'package:tandoorhutweb/view/Billing/BillingHome.dart';
import 'package:tandoorhutweb/view/DashBoard/DashboardHome.dart';
import 'package:tandoorhutweb/view/DeliveryBoy/DeliveryBoyManage.dart';
import 'package:tandoorhutweb/view/Orders/OrderHistory.dart';
import 'package:tandoorhutweb/view/Stock/StockHome.dart';
import 'package:tandoorhutweb/view/offertop/offerTop.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
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
      body: Row(
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
                  top: MediaQuery.of(context).size.height - 700),
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
              NavigationRailDestination(
                icon: Icon(Icons.local_offer),
                selectedIcon: Icon(Icons.local_offer),
                label: Text(
                  'Offer/Top8',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                selectedIcon: Icon(Icons.history),
                label: Text(
                  'Orders',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store),
                selectedIcon: Icon(Icons.store),
                label: Text(
                  'Manage Stock',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),NavigationRailDestination(
                icon: Icon(Icons.delivery_dining),
                selectedIcon: Icon(Icons.delivery_dining),
                label: Text(
                  'Delivery Boy',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
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
                DashBoardHome(),
                OfferTop(),
                OrderHistory(),
                StockHome(),
                DeliveryBoyManage(),
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
