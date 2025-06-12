import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/service_imports.dart';
import '../../service/models/mail_out_model.dart';
import 'widgets/home_widgets_imports.dart' as home_widgets;
import 'package:mobile_email_client/screens/screens_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  var mails;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _startService();
    });

  }

  Future<void> _startService() async {
    final storage = await SharedPreferences.getInstance();
    if(storage.get('mail') != null && storage.get('domain') != null && storage.get('password') != null){
      MailService().start();
      loggedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VerySimpleMail')),
      drawer: const home_widgets.NavigationDrawer(),
      body: Consumer<DatabaseHelper>(
        builder: (context, databasehelper, _) {
          mails = databasehelper.mails;

          if (mails.isEmpty) {
            return const Center(child: Text("No mails yet"));
          }
          return home_widgets.MailListView(mails: mails);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () async {
          if(loggedIn) {
            final mail = await Navigator.push<MailOutModel>(
              context,
              MaterialPageRoute(builder: (_) => const MailCreatorPage()),
            );
            if (mail != null) {
              print(mail.title);
              MailService().send(mail);
            }
          }
          else{
              showDialog<String>(
                context: context,
                builder:
                (BuildContext context) => AlertDialog(
                  title: const Text('You have to be logged in to send mails.'),
                  actions: <Widget>[
                    TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          }
      ),

    );
  }
}
