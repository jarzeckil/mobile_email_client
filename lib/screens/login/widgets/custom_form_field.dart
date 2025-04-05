import 'package:mobile_email_client/app_imports.dart';

class CustomFormField extends StatelessWidget {

  final bool enableHideChar;
  final String hintText;

  CustomFormField(this.enableHideChar, this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      obscureText: enableHideChar,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }
}
