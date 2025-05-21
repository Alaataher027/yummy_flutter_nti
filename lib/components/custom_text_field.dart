import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.onSaved, required this.hint});
  final void Function(String?)? onSaved;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color:
              Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(126, 0, 0, 0)
                  : const Color.fromARGB(125, 255, 255, 255),
        ),
      ),
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Contant Name is required!";
        }
        return null;
      },
    );
  }
}
