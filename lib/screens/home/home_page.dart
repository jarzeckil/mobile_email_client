import 'package:mobile_email_client/app_imports.dart';
import 'widgets/home_widgets_imports.dart' as home_widgets;

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedindex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      drawer: const home_widgets.NavigationDrawer(),
      body: Column(
        children: [

        ],
      ),
    );

  }
}

