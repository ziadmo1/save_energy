import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../themes/myTheme.dart';

showMessage(BuildContext context,
    {required DialogType dialogType,
      required String desc,
      VoidCallback? btnOkOnPress,
    }) {
  AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType,
      title: 'Save Energy',
      desc: desc,
      btnOkOnPress:btnOkOnPress,
      descTextStyle: Theme.of(context).textTheme.bodyMedium,
      titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 18
      ),
      btnOkColor: MyTheme.navyBlue,
      dialogBackgroundColor: Colors.white
  )
    ..show();
}

void showLoading(BuildContext context, String message,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: MyTheme.navyBlue,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                    fontSize: 16
                ),
              )
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}