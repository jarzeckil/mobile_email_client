import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/service_imports.dart';
import 'widgets/custom_form_field.dart';

class AddAccountPage extends StatefulWidget{

  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();

}

class _AddAccountPageState extends State<AddAccountPage> {

  bool _isLoading = false;

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

  Future<void> _saveData(String mail, String domain, String password) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mail', mail);
    await prefs.setString('domain', domain);
    await prefs.setString('password', password);
  }

  Future<void> _logOut() async{
    final prefs = await SharedPreferences.getInstance();
    await DatabaseHelper().clearDatabase();

    await prefs.clear();
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomFormField(false, 'Domain', domainController)
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomFormField(true, 'Password', passwordController)
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() => _isLoading = true);
                          try {
                            await _saveData(
                              usernameController.text,
                              domainController.text,
                              passwordController.text,
                            );
                            final loggedIn = await MailService().start();
                            if (!loggedIn && mounted) {
                              _logOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Logowanie nie powiodło się. Sprawdź dane.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              await Future.delayed(const Duration(seconds: 3));
                              if (mounted) {
                                Navigator.of(context).pushNamed('/home');
                              }
                              return;
                            }

                            if (mounted) {
                              Navigator.of(context).pushNamed('/home');
                            }
                          } finally {
                            if (mounted) {
                              setState(() => _isLoading = false);
                            }
                          }
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  )
                ],
              ),
            )
        )
    );

  }
}