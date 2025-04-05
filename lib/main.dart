import 'app_imports.dart';
import 'screens/screens_imports.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email App',
      theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade800),

      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade800, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.dark,
      home: LoginPage(),
    );
  }
}



