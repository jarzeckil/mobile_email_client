
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

      case '/mail_writer':
        return MaterialPageRoute(builder: (_) => const MailCreatorPage());

      case '/mail_reader':
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          return _errorRoute();
        }

        return MaterialPageRoute(
          builder: (_) => MailReaderPage(
            uid: args['uid'],
            date: args['date'],
            sender: args['sender'],
            subject: args['subject'],
            plainText: args['plainText'],
          ),
        );

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
