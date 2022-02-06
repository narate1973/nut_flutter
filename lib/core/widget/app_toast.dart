import 'package:flutter/material.dart';

class AppToast {
  static SnackBar? _snackBar;

  static Future<SnackBarClosedReason> showError(
    BuildContext context, {
    required String message,
    Key? key,
  }) =>
      _showSnackBar(
        context,
        snackBar: _build(
          context,
          key: key,
          message: message,
          bgColor: Colors.red,
          textColor: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          closeColor: Colors.white,
        ),
      );

  static Future<SnackBarClosedReason> _showSnackBar(
    BuildContext context, {
    required SnackBar snackBar,
  }) {
    _snackBar = snackBar;
    return ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((SnackBarClosedReason reason) {
      _snackBar = null;
      return reason;
    });
  }

  static SnackBar _build(
    BuildContext context, {
    Key? key,
    required Color bgColor,
    required Widget icon,
    required String message,
    required Color textColor,
    required Color closeColor,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    _cancelBeforeShow(context);
    return SnackBar(
      key: key,
      backgroundColor: bgColor,
      duration: const Duration(seconds: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      icon,
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            message,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: scaffoldMessenger.hideCurrentSnackBar,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static _cancelBeforeShow(BuildContext context) {
    if (_snackBar != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
