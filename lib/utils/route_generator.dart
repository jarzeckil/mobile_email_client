import '../screens/screens_imports.dart';
import '../app_imports.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/addaccount':
        return MaterialPageRoute(builder: (_) => AddAccountPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
      );
    });

  }


}