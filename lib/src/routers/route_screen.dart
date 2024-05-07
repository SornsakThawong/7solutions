import 'package:get/get.dart';
import 'package:seven_solutions/src/feature/fibonacci/screens/fibonacci_screen.dart';

import '../feature/initial/screens/splash_screen.dart';
import 'route_path.dart';

class RouteScreen {
  static const initial = RoutePath.splash;

  static final routes = [
    GetPage(
      name: RoutePath.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RoutePath.fibonacci,
      page: () => FibonacciScreen(),
    ),
  ];
}
