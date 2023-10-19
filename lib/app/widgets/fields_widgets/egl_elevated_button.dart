import 'package:flutter/material.dart';

class EglElevatedButton extends StatelessWidget {
  const EglElevatedButton({
    super.key,
    required this.title,
    required this.route,
    required this.textButton,
  });

  final String title;
  final String textButton;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          route,
          arguments: title,
        );
      },
      child: Text(
        textButton,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
