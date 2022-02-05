import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool enabled;
  final bool isLoading;
  final String title;
  final void Function() onPressed;
  final double width;
  final double height;

  const AppButton({
    Key? key,
    this.enabled = true,
    this.isLoading = false,
    this.height = 45,
    this.width = 100,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  bool _canPress() {
    return enabled && !isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _canPress() ? onPressed : null,
      child: Visibility(
        visible: !isLoading,
        child: Text(title),
        replacement: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(
          Size(width, height),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(width, height),
        ),
        backgroundColor: _canPress() ? null : MaterialStateProperty.all<Color>(Colors.grey),
      ),
    );
  }
}
