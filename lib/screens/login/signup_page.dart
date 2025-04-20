import 'package:mobile_email_client/app_imports.dart';


class SignupPage extends StatefulWidget{

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();


}

class _SignupPageState extends State<SignupPage> {

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
                  //child: CustomFormField(false, 'Username'),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //child: CustomFormField(true, 'Password')
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //child: CustomFormField(true, 'Verify password')
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FilledButton(
                      onPressed: () {
                        if(_formKey.currentState?.validate() ?? false){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Creating account'), duration: Duration(seconds: 1),),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please log in now'), duration: Duration(seconds: 1)),
                          ).closed.then((_) {
                            //Navigator.of(context).pushNamed('/');
                          });
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).pushNamed('/');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      )
    );

  }
}