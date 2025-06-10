import 'package:mobile_email_client/app_imports.dart';

class MailReaderPage extends StatelessWidget {
  final int uid;
  final String date;
  final String sender;
  final String subject;
  final String plainText;

  const MailReaderPage({
    super.key,
    required this.uid,
    required this.date,
    required this.sender,
    required this.subject,
    required this.plainText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mail #$uid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From:', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(sender, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text('Date:', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(date, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text('Subject:', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(subject,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Divider(height: 32, thickness: 2),
              Text(
                plainText,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
