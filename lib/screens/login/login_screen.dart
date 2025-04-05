import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/screens/login/widgets/signup_form.dart';
import 'widgets/login_widgets_imports.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignupForm(),
          ],
        ),
      )
    );
  }

}