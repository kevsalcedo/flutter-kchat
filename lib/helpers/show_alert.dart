import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        backgroundColor: Colors.cyan[50],
        actions: [
          MaterialButton(
            onPressed: () => {Navigator.pop(context)},
            elevation: 5,
            textColor: Colors.cyan,
            child: const Text('Ok'),
          )
        ],
      ),
    );
  } else {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text('Ok', style: TextStyle(color: Colors.cyan),),
          )
        ],
      ),
    );
  }
}
