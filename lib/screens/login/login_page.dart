import 'package:mobile_email_client/app_imports.dart';
import 'widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget{

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomFormField(false, 'Username'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomFormField(true, 'Password')
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FilledButton(
                    onPressed: () {
                      if(_formKey.currentState?.validate() ?? false){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing'), duration: Duration(seconds: 1),),
                        ).closed.then((_){
                          Navigator.of(context).pushNamed('/home');
                        });
                      }
                    },
                    child: Text('Sign In'),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
}