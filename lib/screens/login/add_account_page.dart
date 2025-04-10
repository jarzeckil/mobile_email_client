import 'package:mobile_email_client/app_imports.dart';
import 'widgets/custom_form_field.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AddAccountPage extends StatefulWidget{

  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();

}

class _AddAccountPageState extends State<AddAccountPage> {

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final domainController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    domainController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadData(String mail, String domain, String password) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mail', mail);
    await prefs.setString('domain', domain);
    await prefs.setString('password', password);
  }

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
                    child: CustomFormField(false, 'Username', usernameController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomFormField(false, 'Domain', domainController)
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomFormField(true, 'Password', passwordController)
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FilledButton(
                        onPressed: () {
                          if(_formKey.currentState?.validate() ?? false){
                            _loadData(usernameController.text, domainController.text, passwordController.text);
                            Navigator.of(context).pushNamed('/home');
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );

  }
}