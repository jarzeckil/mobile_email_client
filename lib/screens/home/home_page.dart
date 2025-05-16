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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SheMail')),
      drawer: const home_widgets.NavigationDrawer(),
      body: Consumer(
        builder: (context, provider, _) {
          Provider.of<DatabaseHelper>(context, listen: false).loadMails();
          final mails = DatabaseHelper().mails;

          if (mails.isEmpty) {
            return const Center(child: Text("No mails yet"));
          }
          return ListView.builder(
            itemCount: mails.length,
            itemBuilder: (context, index) {
              final mail = mails[index];
              return MailCard(
                subject: mail.subject,
                date: mail.date,
                sender: mail.sender,
                body: ",",
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<DatabaseHelper>(context, listen: false).loadMails();
          print(
            Provider.of<DatabaseHelper>(
              context,
              listen: false,
            ).mails[0].toString(),
          );
        },
      ),
    );
  }
}
