import 'package:flutter/material.dart';
import 'package:todo_app_c11_mon/core/page_route_names.dart';

import '../features/layout_view.dart';
import '../features/login/login_view.dart';
import '../features/registrition/registration.dart';
import '../features/splash/splash_view.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(
          builder: (context) => SplashView(),
          settings: settings,
        );
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case PageRouteName.registration:
        return MaterialPageRoute(
          builder: (context) => RegistrationView(),
          settings: settings,
        );
      case PageRouteName.layout:
        return MaterialPageRoute(
          builder: (context) => LayoutView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SplashView(),
        );
    }
  }
}
