import 'package:flutter/material.dart';

typedef DialogOptionsBuilder<T> = Map<String, T?> Function();
Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    required DialogOptionsBuilder<T> optionsBuilder}) {
  final options = optionsBuilder();
  return showDialog<T>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(ctx).pop(value);
                  } else {
                    Navigator.of(ctx).pop(null);
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
