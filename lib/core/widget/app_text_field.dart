import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final bool isObscure;
  final bool obscureText;
  final Function(String) onChange;

  const AppTextField({
    required this.onChange,
    Key? key,
    this.hintText,
    this.isObscure = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = widget.obscureText ? true : widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        obscureText: isObscure,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: Visibility(
            visible: widget.obscureText,
            child: IconButton(
              icon: Visibility(
                visible: isObscure,
                child: const Icon(Icons.remove_red_eye_rounded),
                replacement: const Icon(Icons.remove_red_eye_outlined),
              ),
              onPressed: () {
                setState(() => isObscure = !isObscure);
              },
            ),
          ),
        ),
      ),
    );
  }
}
