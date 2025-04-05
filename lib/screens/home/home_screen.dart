import 'package:mobile_email_client/app_imports.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedindex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(

      ),
      drawer: const NavigationDrawer(),
      body: Column(
        children: [

        ],
      ),
    );

  }
}

class NavigationDrawer extends StatelessWidget{

  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [

      ],
    ),
  );

}