// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:asocapp/app/utils/utils.dart';

import '../../resources/resources.dart';

class EglArticleListTile extends StatelessWidget {
  const EglArticleListTile({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.logo,
    required this.category,
    required this.subcategory,
    this.state = '',
    required this.leadingImage,
    required this.trailingImage,
    required this.onTap,
    required this.onTapCategory,
    required this.onTapSubcategory,
    required this.backgroundColor,
    required this.colorBorder,
    this.colorState = Colors.transparent,
    this.gradient = Colors.transparent,
  });

// input data
  final int index;
  final String title;
  final String subtitle;
  final String logo;
  final String category;
  final String subcategory;
  final String state;
  final String leadingImage;
  final String? trailingImage;
  final VoidCallback onTap;
  final VoidCallback onTapCategory;
  final VoidCallback onTapSubcategory;
  final Color backgroundColor;
  final Color colorBorder;
  final Color colorState;
  final Color gradient;

  // local variables

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            // borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            // gradient: LinearGradient(colors: [color, gradient], begin: Alignment.topCenter, end: Alignment.topRight),
            border: Border(
              bottom: BorderSide(
                color: colorBorder,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      leadingImage,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title.toUpperCase(),
                              // maxLines: 2,
                              textAlign: TextAlign.center,
                              style: AppTheme.headline1.copyWith(
                                // color: Colors.black,
                                // fontWeight: FontWeight.w800,
                                // fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: title.length > 50 ? 12 : 16,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              subtitle.length > 100 ? '   ${subtitle.substring(0, 96)} ...' : '   $subtitle',
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              style: AppTheme.bodyText2.copyWith(
                                // color: Colors.black,
                                // fontWeight: FontWeight.w800,
                                // fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 14,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: onTapCategory,
                                    child: Text(
                                      category,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const Text(
                                    '/',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  InkWell(
                                    onTap: onTapSubcategory,
                                    child: Text(
                                      subcategory,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state,
                                    style: TextStyle(fontSize: 10, color: colorState),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
