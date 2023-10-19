import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EglStackListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logo;
  final Widget trailingImage;
  final VoidCallback onTab;
  final Color color;
  final Color gradient;

  const EglStackListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.logo,
    required this.trailingImage,
    required this.onTab,
    required this.color,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: GestureDetector(
        onTap: onTab,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Card(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      gradient: LinearGradient(colors: [color, gradient], begin: Alignment.topCenter, end: Alignment.topRight),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(title),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            subtitle,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ))),
            if (logo != '') Logo(logo: logo),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(child: trailingImage),
            )
          ],
        ),
      ),
    );
  }
}
