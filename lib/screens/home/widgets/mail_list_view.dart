import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/mail_service.dart';
import 'package:mobile_email_client/service/models/mail_model.dart';
import 'mail_card.dart';

class MailListView extends StatefulWidget {
  final List<MailModel> mails;

  const MailListView({
    super.key,
    required this.mails,
  });

  @override
  State<MailListView> createState() => _MailListViewState();
}

class _MailListViewState extends State<MailListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !_isLoading) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    try {
      await MailService().loadPrev(20);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mails = widget.mails;

    return ListView.builder(
      controller: _scrollController,
      itemCount: mails.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == mails.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final mail = mails[index];
        return MailCard.noBody(
          subject: mail.subject,
          date: mail.date,
          sender: mail.sender,
          onTap: () {
            Navigator.of(context).pushNamed(
              '/mail_reader',
              arguments: {
                'uid': mail.uid,
                'date': mail.date,
                'sender': mail.sender,
                'subject': mail.subject,
                'plainText': mail.plainText,
              },
            );
          },
        );
      },
    );
  }
}
