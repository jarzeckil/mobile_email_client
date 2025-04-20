import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/screens/home/widgets/mail_card.dart';
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
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [for (int i = 0; i < 20; i++) const MailCard(subject: '.', date: '.', sender: '.', body: '.',)],
            ),
          ),
        ],
      ),
    );
  }
}
