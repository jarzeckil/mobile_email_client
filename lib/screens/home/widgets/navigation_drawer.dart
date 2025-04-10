import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/service_imports.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    Object? mail = await prefs.get('mail');
    Object? domain = await prefs.get('domain');
    Object? password = await prefs.get('password');

    return 'Mail: $mail Domain: $domain Password: $password';
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Add account'),
          onTap: () {
            Navigator.of(context).pushNamed('/addaccount');
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Get account information'),
          onTap: () {
                showDialog<String>(
                  context: context,
                  builder:
                      (BuildContext context) => AlertDialog(
                    title: const Text('Account details'),
                    content: FutureBuilder(
                        future: _getData(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            return Text(snapshot.data ?? 'No data');
                          }
                        }
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
        ),
        ListTile(
          leading: Icon(Icons.sync),
          title: Text('Start service'),
          onTap: () async {
            final mailService = MailService();
            await mailService.connectService();
            await mailService.listen();
          },
        ),
      ],
    ),
  );
}
