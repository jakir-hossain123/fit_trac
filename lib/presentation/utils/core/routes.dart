import 'package:flutter/widgets.dart';
import '../../screens/home_screens.dart';
import '../../screens/sign_in_page.dart';
import '../../screens/sign_up_page.dart';



class AppRoutes {
  //  default route Home
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    signIn: (context) => const SignInPage(),
    signUp: (context) => const SignUpPage(),
  };
}