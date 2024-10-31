import 'package:flutter/material.dart';

ScaffoldFeatureController showSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}

ScaffoldFeatureController showErrorSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}
