import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/screens/home/widgets/mail_card.dart';
import 'widgets/home_widgets_imports.dart' as home_widgets;
import 'package:mobile_email_client/service/service_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;

  final db = DatabaseHelper();
  late List<Map<String, dynamic>> mapList;
  List<MailModel> mails = List.empty();

  @override
  void initState() {
    super.initState();
    print("initing home");
    //TODO
    // OBLSUGA SNAPSHOTÓW
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SheMail')),
      drawer: const home_widgets.NavigationDrawer(),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                for (MailModel mail in mails)
                  MailCard(
                    subject: mail.subject,
                    date: mail.date,
                    sender: mail.sender,
                    body: ",",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
