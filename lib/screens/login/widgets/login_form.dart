import 'package:mobile_email_client/app_imports.dart';
import 'custom_form_field.dart';

class LoginForm extends StatefulWidget{

  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
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
                      const SnackBar(content: Text('Processing')),
                    );
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
                    print('Kliknięto link!');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );


  }
}