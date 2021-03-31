import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tandoorhutweb/models/booking.dart';
import 'package:tandoorhutweb/services/bookingService.dart';
import 'package:tandoorhutweb/services/tableService.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  int totalTableCount = 0;
  int _index = 0;
  TabController _tabController;
  List<Booking> todayBookings = [];
  List<Booking> pastBookings = [];
  bool isLoading = false;
  bool isLoading2 = false;


  int page = 0;
  ScrollController _sc = new ScrollController();

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _index);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getMorePastBooking();
      }
    });
    getTodayData();
    super.initState();
  }

  getMorePastBooking() async {
    setState(() {
      isLoading2 = true;
    });
    List<Booking> tempList = await BookingService.getPastBookingByCount(
        page,
        15,
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    setState(() {
      pastBookings.addAll(tempList);
      page += 15;
      isLoading2 = false;
    });
  }

  getTodayData() async {
    setState(() {
      isLoading = true;
    });
    todayBookings = await BookingService.getTodayBooking(
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    pastBookings = await BookingService.getPastBookingByCount(page, 15,
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    totalTableCount = await TableService.tableCount();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                            onPressed: () async{
                              bool added = await TableService.createTable(totalTableCount+1);
                              if(added){
                                getTodayData();
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    unselectedLabelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  flex: 9,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      todayBookings.length == 0
                          ? Center(
                              child: Text(
                                "No Bookings",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            )
                          : ListView.builder(
                              itemCount: todayBookings.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: richieText(
                                    'Table No: ',
                                    todayBookings[index].tableId,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      richieText(
                                          "Booked By: ",
                                          todayBookings[index].customer.name +
                                              " (+91 ${todayBookings[index].customer.phone})"),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      richieText(
                                          "Status: ",
                                          todayBookings[index].canceled
                                              ? "Canceled"
                                              : "Booked"),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      richieText(
                                        'Reservation Slot: ',
                                        "${timeClassToActual(todayBookings[index].startTimeId)} to ${timeClassToActual(todayBookings[index].endTimeId)}",
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      richieText(
                                        'Booked on: ',
                                        todayBookings[index]
                                            .createdAt
                                            .toLocal()
                                            .toString(),
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                      pastBookings.length == 0
                          ? Center(
                              child: Text(
                                "No Bookings",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            )
                          : ListView.builder(
                              controller: _sc,
                              itemCount: pastBookings.length + 1,
                              itemBuilder: (context, index) {
                                return index == pastBookings.length
                                    ? Center(
                                        child: isLoading2
                                            ? CircularProgressIndicator()
                                            : Container(),
                                      )
                                    : ListTile(
                                        title: richieText(
                                          'Table No: ',
                                          pastBookings[index].tableId,
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            richieText(
                                                "Booked By: ",
                                                pastBookings[index]
                                                        .customer
                                                        .name +
                                                    " (+91 ${pastBookings[index].customer.phone})"),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            richieText(
                                                "Status: ",
                                                pastBookings[index].canceled
                                                    ? "Canceled"
                                                    : "Booked"),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            richieText(
                                              'Reservation Slot: ',
                                              "${timeClassToActual(pastBookings[index].startTimeId)} to ${timeClassToActual(pastBookings[index].endTimeId)}",
                                            ),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            richieText(
                                              'Booked on: ',
                                              pastBookings[index]
                                                  .createdAt
                                                  .toLocal()
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              width: 24,
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  richieText(title, trail) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
        children: <TextSpan>[
          TextSpan(
            text: trail,
            style: TextStyle(fontSize: 19, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

timeClassToActual(String id) {
  TimeClass current =
      timeList.where((element) => element.id == int.parse(id)).first;
  return ("${current.hr} : ${current.min}");
}

class TimeClass {
  TimeClass({this.hr, this.min, this.id});

  final int hr;
  final int min;
  final int id;
}

List timeList = [
  TimeClass(id: 1, hr: 11, min: 00),
  TimeClass(id: 2, hr: 11, min: 15),
  TimeClass(id: 3, hr: 11, min: 30),
  TimeClass(id: 4, hr: 11, min: 45),
  TimeClass(id: 5, hr: 12, min: 00),
  TimeClass(id: 6, hr: 12, min: 15),
  TimeClass(id: 7, hr: 12, min: 30),
  TimeClass(id: 8, hr: 12, min: 45),
  TimeClass(id: 9, hr: 13, min: 00),
  TimeClass(id: 10, hr: 13, min: 00),
  TimeClass(id: 11, hr: 13, min: 15),
  TimeClass(id: 12, hr: 13, min: 30),
  TimeClass(id: 13, hr: 13, min: 45),
  TimeClass(id: 14, hr: 14, min: 00),
  TimeClass(id: 15, hr: 14, min: 15),
  TimeClass(id: 16, hr: 14, min: 30),
  TimeClass(id: 17, hr: 14, min: 45),
  TimeClass(id: 18, hr: 15, min: 00),
  TimeClass(id: 19, hr: 15, min: 15),
  TimeClass(id: 20, hr: 15, min: 30),
  TimeClass(id: 21, hr: 15, min: 45),
  TimeClass(id: 22, hr: 16, min: 00),
  TimeClass(id: 23, hr: 16, min: 15),
  TimeClass(id: 24, hr: 16, min: 30),
  TimeClass(id: 25, hr: 16, min: 45),
  TimeClass(id: 26, hr: 17, min: 00),
  TimeClass(id: 27, hr: 17, min: 15),
  TimeClass(id: 28, hr: 17, min: 30),
  TimeClass(id: 29, hr: 17, min: 45),
  TimeClass(id: 30, hr: 18, min: 00),
  TimeClass(id: 31, hr: 18, min: 15),
  TimeClass(id: 32, hr: 18, min: 30),
  TimeClass(id: 33, hr: 18, min: 45),
  TimeClass(id: 34, hr: 19, min: 00),
  TimeClass(id: 35, hr: 19, min: 15),
  TimeClass(id: 36, hr: 19, min: 30),
  TimeClass(id: 37, hr: 19, min: 45),
  TimeClass(id: 38, hr: 20, min: 00),
  TimeClass(id: 39, hr: 20, min: 15),
  TimeClass(id: 40, hr: 20, min: 30),
  TimeClass(id: 41, hr: 20, min: 45),
  TimeClass(id: 42, hr: 21, min: 00),
  TimeClass(id: 43, hr: 21, min: 15),
  TimeClass(id: 44, hr: 21, min: 30),
  TimeClass(id: 45, hr: 21, min: 45),
  TimeClass(id: 46, hr: 22, min: 00),
];
