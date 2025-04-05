import 'package:mobile_email_client/app_imports.dart';
import 'custom_form_field.dart';


class SignupForm extends StatefulWidget{

  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();


}

class _SignupFormState extends State<SignupForm> {

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
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomFormField(true, 'Verify password')
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: FilledButton(
                onPressed: () {
                  if(_formKey.currentState?.validate() ?? false){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Creating account')),
                    );
                  }
                },
                child: Text('Sign Up'),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              children: [
                TextSpan(
                  text: 'Sign In',
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