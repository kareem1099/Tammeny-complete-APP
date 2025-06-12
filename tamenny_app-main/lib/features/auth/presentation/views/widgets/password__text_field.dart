import 'package:flutter/material.dart';
import 'package:tamenny_app/core/functions/validator.dart';
import 'package:tamenny_app/core/widgets/custom_text_form_field.dart';
import 'package:tamenny_app/generated/l10n.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.text,
    this.onSaved,
    this.controller,
  });

  final String? text;
  final Function(String?)? onSaved;
  final TextEditingController? controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.text ?? S.of(context).password,
      onSaved: widget.onSaved,
      validate: Validator.validatePassword,
      obscure: isObscure,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: Icon(
          isObscure ? Icons.remove_red_eye : Icons.visibility_off,
        ),
      ),
    );
  }
}
