import 'package:flutter/material.dart';
import 'package:fluttertask/BaseScreen.dart';
import 'package:fluttertask/core/utils/routes_strings.dart';
import 'package:fluttertask/presentation/screens/cart_screen.dart';
import 'package:fluttertask/presentation/screens/home_screen.dart';
import 'package:fluttertask/presentation/screens/login.dart';



class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteString.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case RouteString.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteString.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      // case RouteString.userprofile:
      //   return MaterialPageRoute(builder: (_) => const UserProfileScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }


}
