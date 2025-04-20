import 'package:mobile_email_client/app_imports.dart';

class MailCard extends StatelessWidget{

  final String subject;
  final String sender;
  final String date;
  final String body;

  const MailCard({super.key, required this.subject, required this.date, required this.sender, required this.body});
  const MailCard.noBody({super.key, required this.subject, required this.date, required this.sender, this.body = ""});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.normal,
      fontSize: 30,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 20,
      child: Column(
        children: [
          Row(
            children: [
              Text(sender, style: style,),
              const Spacer(),
              Text(date, style: style,),
            ],
          ),
          Align(alignment: AlignmentDirectional.centerStart, child: Text(subject, style: style,)),
          Align(alignment: AlignmentDirectional.centerStart, child: Text(body, style: style,)),
        ],
      ),
    );
  }





}