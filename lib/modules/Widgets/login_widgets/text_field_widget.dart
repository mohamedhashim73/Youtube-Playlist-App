import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool? obscureText;
  const TextFieldWidget({Key? key,this.obscureText,required this.hint,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (input)
      {
        if( controller.text.isNotEmpty )
        {
          return null;
        }
        else
        {
          return "$hint must not be empty";
        }
      },
    );
  }
}
