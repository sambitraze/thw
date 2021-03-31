import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  int totalTableCount = 10;
  int _index = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Total Tables: $totalTableCount",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: totalTableCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.orange,
                        ),
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Table ${index + 1}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  flex: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: Colors.orange,
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.orange,
              labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              unselectedLabelStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "Today's Booking",
                ),
                Tab(
                  text: "Past Booking",
                ),
              ],
              onTap: (value) {
                setState(() {
                  _index = value;
                });
                _tabController.animateTo(value,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500));
              },
            ),
          ),
          SizedBox(height: 32,),
          Expanded(
            flex: 9,
            child: TabBarView(
               physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                ListView.builder(
                    itemBuilder: (context, index) => Container(
                          height: 100,
                          width: 500,
                          color: Colors.teal,
                        )),
                ListView.builder(
                    itemBuilder: (context, index) => Container(
                          height: 100,
                          width: 500,
                          color: Colors.greenAccent,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
