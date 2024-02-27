// ignore_for_file: prefer_const_constructors

import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/controllers/controllers.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Demo Home Page'),
      // ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage(EglImagesPath.lightAppLogo),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Eglos', style: TextStyle(fontFamily: AppFonts.sfProDisplayBold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
