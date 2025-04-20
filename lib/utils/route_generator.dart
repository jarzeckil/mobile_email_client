import '../screens/screens_imports.dart';
import '../app_imports.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/addaccount':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(appBar: AppBar(title: const Text('Error')));
      },
    );
  }
}
