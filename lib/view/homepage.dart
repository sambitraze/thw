import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tandoorhutweb/services/notificationService.dart';
import 'package:tandoorhutweb/view/Auth/LoginScreen.dart';
import 'package:tandoorhutweb/view/Billing/BillingHome.dart';
import 'package:tandoorhutweb/view/Booking/bookingScreen.dart';
import 'package:tandoorhutweb/view/DashBoard/DashboardHome.dart';
import 'package:tandoorhutweb/view/DeliveryBoy/DeliveryBoyManage.dart';
import 'package:tandoorhutweb/view/Orders/OrderHistory.dart';
import 'package:tandoorhutweb/view/Stock/StockHome.dart';
import 'package:tandoorhutweb/view/offertop/offerTop.dart';
import 'package:tandoorhutweb/view/settings/SettingScreen.dart';

class MyHomePage extends StatefulWidget {
  final int index;
  MyHomePage({Key key, this.title, this.index}) : super(key: key);

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
      initialPage: widget.index != null ? widget.index : 0,
      keepPage: true,
    );
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              message.notification.body,
              style: TextStyle(fontSize: 24),
            ),
            title: Text(
              message.notification.title,
              style: TextStyle(fontSize: 32),
            ),
          ),
        );
      },
    );
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
              pageController.jumpToPage(index);
            },
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'), radius: 30),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height - 850),
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
                  pref.clear();
                  // await NotificationService.unsubscribeTopTopic();
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
              ),
              NavigationRailDestination(
                icon: Icon(Icons.menu_book),
                selectedIcon: Icon(Icons.menu_book),
                label: Text(
                  'Bookings',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              NavigationRailDestination(
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
              NavigationRailDestination(
                icon: Icon(Icons.notifications),
                selectedIcon: Icon(Icons.notifications_active_rounded),
                label: Text(
                  'Settings',
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
                BookingScreen(),
                DeliveryBoyManage(),
                BillingHome(),
                SettingScreen(),
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
