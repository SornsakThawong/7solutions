import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seven_solutions/src/routers/route_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteScreen.initial,
      getPages: RouteScreen.routes,
    );
  }
}
