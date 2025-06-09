import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/screens/home/widgets/mail_card.dart';
import 'package:mobile_email_client/service/service_imports.dart';
import 'package:provider/provider.dart';
import 'widgets/home_widgets_imports.dart' as home_widgets;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  var mails;

  @override
  void initState() {
    super.initState();
    MailService().start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SheMail')),
      drawer: const home_widgets.NavigationDrawer(),
      body: Consumer<DatabaseHelper>(
        builder: (context, databasehelper, _) {
          mails = databasehelper.mails;

          if (mails.isEmpty) {
            return const Center(child: Text("No mails yet"));
          }
          return ListView.builder(
            itemCount: mails.length,
            itemBuilder: (context, index) {
              final mail = mails[index];
              return MailCard.noBody(
                subject: mail.subject,
                date: mail.date,
                sender: mail.sender,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/mail_reader',
                    arguments: {
                      'uid': mail.uid,
                      'date': mail.date,
                      'sender': mail.sender,
                      'subject': mail.subject,
                      'plainText': mail.plainText,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
