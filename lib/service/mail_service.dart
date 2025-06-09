import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/service_imports.dart';

class MailService {
  static MailService? _service;
  MailService._();

  factory MailService() {
    _service ??= MailService._();
    return _service!;
  }

  String userName = '';
  String password = '';
  String domain = '';

  static late MailClient mailClient;
  static bool connected = false;

  Future<void> _loadData() async {
    final storage = await SharedPreferences.getInstance();
    userName = (storage.get('mail')) as String;
    domain = (storage.get('domain')) as String;
    password = (storage.get('password')) as String;
  }

  Future<void> start() async {
    await connectService();
    await listen();
  }

  Future<void> stop() async {
    if (connected) {
      connected = false;
      mailClient.disconnect();
    }
  }

  Future<void> connectService() async {
    await _loadData();
    final email = '$userName@$domain';
    print('discovering settings for  $email...');
    final config = await Discover.discover(email);
    if (config == null) {
      print('Unable to auto-discover settings for $email');
      return;
    }
    print('connecting to ${config.displayName}.');
    final account = MailAccount.fromDiscoveredSettings(
      name: 'my account',
      email: email,
      password: password,
      config: config,
      userName: userName,
    );
    connected = true;
    mailClient = MailClient(account, isLogEnabled: true);
  }

  Future<void> listen() async {
    try {
      await mailClient.connect();
      print('connected');
      await mailClient.selectInbox();

      final db = DatabaseHelper();


      final messages = await mailClient.fetchMessages(count: 100);
      messages.forEach(db.insertMail);

      mailClient.eventBus.on<MailLoadEvent>().listen((event) {
        print('New message at ${DateTime.now()}:');
        db.insertMail(event.message);
      });
      await mailClient.startPolling();
    } on MailException catch (e) {
      print('High level API failed with $e');
    }
  }

  void printMessage(MimeMessage message) {
    print('from: ${message.from} with subject "${message.decodeSubject()}"');
    if (!message.isTextPlainMessage()) {
      print(' content-type: ${message.mediaType}');
    } else {
      final plainText = message.decodeTextPlainPart();
      if (plainText != null) {
        final lines = plainText.split('\r\n');
        for (final line in lines) {
          if (line.startsWith('>')) {
            // break when quoted text starts
            break;
          }
          print(line);
        }
      }
    }
  }
}
