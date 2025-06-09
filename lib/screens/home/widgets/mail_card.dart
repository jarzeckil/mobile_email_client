import 'package:mobile_email_client/app_imports.dart';

class MailCard extends StatelessWidget {
  final String subject;
  final String sender;
  final String date;
  final String body;
  final VoidCallback? onTap;


  const MailCard.noBody({
    super.key,
    required this.subject,
    required this.date,
    required this.sender,
    this.body = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onPrimary;

    return InkWell(
      onTap: onTap,
      child: Card(
        color: theme.colorScheme.primary,
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // lepsze wyrównanie
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      sender,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    DateTime.parse(date).toString(),
                    style: theme.textTheme.bodySmall?.copyWith(color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subject,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (body.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  body,
                  style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
