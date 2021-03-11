import 'package:flutter/material.dart';
import 'package:tandoorhutweb/view/Auth/LoginScreen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
