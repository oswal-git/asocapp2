import 'package:asocapp/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EglListTileCopy extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logo;
  final String category;
  final String subcategory;
  final String leadingImage;
  final String? trailingImage;
  final VoidCallback onTab;
  final Color color;
  final Color gradient;

  EglListTileCopy({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logo,
    required this.category,
    required this.subcategory,
    required this.leadingImage,
    required this.trailingImage,
    required this.onTab,
    required this.color,
    required this.gradient,
  });

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: GestureDetector(
        onTap: onTab,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 22, 22),
            border: Border.all(
              color: const Color.fromARGB(255, 7, 46, 176),
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Container(
              alignment: Alignment.center,
              width: 80,
              // height: 1000,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 198, 241, 176),
                border: Border.all(
                  color: const Color.fromARGB(255, 4, 123, 170),
                  width: 1,
                ),
              ),
              child: Center(
                child: Image(
                  image: NetworkImage(leadingImage),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            title: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(colors: [color, gradient], begin: Alignment.topLeft, end: Alignment.topRight),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(title),
              ),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 198, 241, 176),
                border: Border.all(
                  color: const Color.fromARGB(255, 131, 4, 42),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    4.ph,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            logger.i('link: $category');
                          },
                          child: Text(
                            category,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            logger.i('link: $category/$subcategory');
                          },
                          child: Text(
                            subcategory,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
