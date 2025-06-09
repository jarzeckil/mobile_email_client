import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/service_imports.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final Object? mail = prefs.get('mail');
    final Object? domain = prefs.get('domain');
    final Object? password = prefs.get('password');

    return 'Mail: $mail Domain: $domain Password: $password';
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add account'),
          onTap: () {
            Navigator.of(context).pushNamed('/addaccount');
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Get account information'),
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
                            return const Text('Error');
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
          leading: const Icon(Icons.sync),
          title: const Text('Start service'),
          onTap: () async {
            await MailService().start();
          },
        ),
        ListTile(
          leading: const Icon(Icons.stop),
          title: const Text('Stop service'),
          onTap: () async {
            await MailService().stop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete_forever),
          title: const Text('Delete database'),
          onTap: () async {
            DatabaseHelper().deleteDatabaseFile();
          },
        ),
      ],
    ),
  );
}
