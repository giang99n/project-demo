// import 'package:demo_manager/ui/Screens/Login/login_screen.dart';
// import 'package:demo_manager/ui/Screens/Signup/signup_screen.dart';
// import 'package:demo_manager/ui/screens/home/home_screen.dart';
// import 'package:flutter/material.dart';
//
//
// enum Routes { splash, home, login, signup }
//
// class _Paths {
//   static const String splash = '/';
//   static const String home = '/home';
//   static const String login = '/login';
//   static const String signup = '/signup';
//
//   static const Map<Routes, String> _pathMap = {
//     Routes.splash: _Paths.splash,
//     Routes.home: _Paths.home,
//     Routes.login: _Paths.login,
//     Routes.signup: _Paths.signup,
//   };
//
//   static String of(Routes route) => _pathMap[route];
// }
//
// class AppNavigator {
//   AppNavigator._();
//
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
//
//   static Route onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       // case _Paths.splash:
//       //   return MaterialPageRoute(builder: (_) => SplashScreen());
//       case _Paths.home:
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//       case _Paths.login:
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//       case _Paths.signup:
//         return MaterialPageRoute(
//           builder: (_) => SignUpScreen(),
//         );
//       default:
//         throw Exception('Invalid route: ${settings.name}');
//     }
//   }
//
//   static Future push<T>(Routes route, [T? arguments]) =>
//       state!.pushNamed(_Paths.of(route), arguments: arguments);
//
//   static Future replaceWith<T>(Routes route, [T? arguments]) =>
//       state!.pushReplacementNamed(_Paths.of(route), arguments: arguments);
//
//   static void pop<T>([T? result]) => state!.pop(result);
//
//   static NavigatorState? get state => navigatorKey.currentState;
// }
