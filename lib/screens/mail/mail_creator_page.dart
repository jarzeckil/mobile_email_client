import 'package:mobile_email_client/app_imports.dart';

import '../../service/models/mail_out_model.dart';

class MailCreatorPage extends StatefulWidget {
  const MailCreatorPage({super.key});

  @override
  State<MailCreatorPage> createState() => _MailCreatorPageState();
}

class _MailCreatorPageState extends State<MailCreatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _sendMail() {
    if (_formKey.currentState?.validate() ?? false) {
      final mail = MailOutModel(
        _titleController.text.trim(),
        _bodyController.text.trim(),
        _toController.text.trim(),
      );
      Navigator.of(context).pop(mail); // zwrócenie obiektu do poprzedniej strony
    }
  }

  @override
  void dispose() {
    _toController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create Email")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _toController,
                decoration: const InputDecoration(labelText: "To"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter recipient";
                  }
                  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Subject"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter subject" : null,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(labelText: "Body"),
                  maxLines: null,
                  expands: true,
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter body" : null,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _sendMail,
                icon: const Icon(Icons.send),
                label: const Text("Send"),
              )
            ],
          ),
        ),
      ),
    );
  }
}