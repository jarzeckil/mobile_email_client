import 'package:mobile_email_client/app_imports.dart';

class CustomFormField extends StatelessWidget {

  final bool enableHideChar;
  final String hintText;
  final TextEditingController myController;

  CustomFormField(this.enableHideChar, this.hintText, this.myController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
