import 'package:flutter/material.dart';
import 'package:tandoorhutweb/view/Auth/LoginScreen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  var token = await messaging.getToken(
      vapidKey:
          "BG8mGeAu8pxrQEYh9ZSz2Vb7az_0jl8x6gcO6uMEEKAu47p6a0MwZjN5g7LBQk1SyrtqxC2psACzcH8PS-Mnzb4");
  print(token);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tandoor Hut',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ),tandoorHut@2021
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 4000,
          minWidth: 1920,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(4000, name: MOBILE),
            ResponsiveBreakpoint.autoScale(3000, name: TABLET),
            ResponsiveBreakpoint.autoScale(1920, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      home: LoginScreen(),
    );
  }
}
