import 'package:mobile_email_client/app_imports.dart';

class MailService {

  factory MailService() => _this;
  MailService._();
  static final MailService _this = MailService._();

  String userName = '';
  String password = '';
  String domain = '';

  var mailClient;

  Future<void> _loadData() async{
    final storage = await SharedPreferences.getInstance();
    userName = (await storage.get('mail')) as String;
    domain = (await storage.get('domain')) as String;
    password = (await storage.get('password')) as String;
  }

  /// Builds a simple example message
  MimeMessage buildMessage() {
    final builder =
        MessageBuilder.prepareMultipartAlternativeMessage(
            plainText: 'Hello world!',
            htmlText: '<p>Hello world!</p>',
          )
          ..from = [MailAddress('Personal Name', '$userName@$domain')]
          ..to = [
            MailAddress('Recipient Personal Name', 'arax908@gmail.com'),
            MailAddress('Other Recipient', 'other@domain.com'),
          ];
    return builder.buildMimeMessage();
  }

  /// Builds an example message with attachment
  Future<MimeMessage> buildMessageWithAttachment() async {
    final builder =
        MessageBuilder()
          ..from = [MailAddress('Personal Name', 'sender@domain.com')]
          ..to = [
            MailAddress('Recipient Personal Name', 'recipient@domain.com'),
            MailAddress('Other Recipient', 'other@domain.com'),
          ]
          ..addMultipartAlternative(
            plainText: 'Hello world!',
            htmlText: '<p>Hello world!</p>',
          );
    final file = File.fromUri(Uri.parse('file://./document.pdf'));
    await builder.addFile(file, MediaSubtype.applicationPdf.mediaType);
    return builder.buildMimeMessage();
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
    mailClient = MailClient(account, isLogEnabled: true);
  }

  /// High level mail API example
  Future<void> listen() async {
    try {
      await mailClient.connect();
      print('connected');
      final mailboxes = await mailClient.listMailboxesAsTree(
        createIntermediate: false,
      );
      print(mailboxes);
      await mailClient.selectInbox();
      final messages = await mailClient.fetchMessages(count: 20);
      messages.forEach(printMessage);
      mailClient.eventBus.on<MailLoadEvent>().listen((event) {
        print('New message at ${DateTime.now()}:');
        printMessage(event.message);
        print(messages.elementAt(0).body);
      });
      await mailClient.startPolling();
      // generate and send email:
      //final mimeMessage = buildMessage();
      //await mailClient.sendMessage(mimeMessage);
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
