import 'package:flutter/material.dart';

void snackMessage(BuildContext context, message, [bool isError = false]){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.blue,
    ),
  );
}