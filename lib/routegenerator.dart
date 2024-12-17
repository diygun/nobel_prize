import 'package:flutter/material.dart';
import 'package:nobel_prize/main.dart';
import 'package:nobel_prize/register.dart';

import 'home.dart';
import 'login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/example-with-args':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RegisterPage(
                // data: args,
                ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
