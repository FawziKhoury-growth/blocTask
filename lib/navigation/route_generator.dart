import 'package:bloctask/presentation/screens/guests_rooms.dart';
import 'package:bloctask/presentation/screens/home_page_screen.dart';
import 'package:bloctask/presentation/screens/loading_screen.dart';
import 'package:bloctask/presentation/screens/sign_in.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/registration.dart';

class RouteGenerator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final String routeName = settings.name!;

    switch (routeName) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePageScreen());

      case '/signup':
        return MaterialPageRoute(builder: (_) => Registration());

      case '/signin':
        return MaterialPageRoute(builder: (_) => SignIn());

      case '/loadingScreen':
        return MaterialPageRoute(builder: (_) => LoadingScreen());

      case '/guestRoom':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              GuestsRooms(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Initial position (off screen)
            const end = Offset(0, 0.15); // Final position (on screen)
            const curve = Curves.easeInOut; // Transition curve
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          opaque: false,
          barrierDismissible: false,
        );

      default:
        return MaterialPageRoute(builder: (_) => errorRoute());
    }
  }
}

class errorRoute extends StatelessWidget {
  const errorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('404 Not Found')),
      body: Center(child: Text('Page not found')),
    );
  }
}
