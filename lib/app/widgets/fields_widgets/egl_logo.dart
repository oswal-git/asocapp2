import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final String logo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
      child: Image(
        image: NetworkImage(logo),
        height: 110,
      ),
    );
  }
}
