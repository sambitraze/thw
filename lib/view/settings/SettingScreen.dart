import 'package:flutter/material.dart';
import 'package:tandoorhutweb/models/deviceToken.dart';
import 'package:tandoorhutweb/services/notificationService.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool loading = false;
  List<DeviceToken> tokens = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    tokens = await NotificationService.getallToken();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.all(48),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                ListTile(
                  title: Text("Turn on Notification: "),
                  trailing: MaterialButton(
                    child: Text("Press"),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please wait for 5 to 10 second",
                          ),
                        ),
                      );
                      bool response =
                          await NotificationService.subscribeTopTopic();
                      if (response) {
                        getData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Notification activated for this system",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Notification activation failed for this system",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text("Turn off Notification: "),
                  trailing: MaterialButton(
                    child: Text("Press"),
                    onPressed: () async {
                      bool response =
                          await NotificationService.unsubscribeTopTopic();
                      if (response) {
                        getData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Notification deactivated for this system",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Notification deactivation failed for this system",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                      "Device List currently recving notification about orders: "),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tokens.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tokens[index].user),
                        subtitle: Text(tokens[index].createdAt.toLocal().toString()),
                        trailing: MaterialButton(
                          child: Text("delete"),
                          onPressed: () async {
                            bool response =
                                await NotificationService.unsubscribeone(
                                    tokens[index].devicetoken, tokens[index].id);
                            if (response) {
                              getData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Notification deactivated for the selected system",
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Notification deactivation failed for selected system",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
