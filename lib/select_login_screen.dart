import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magazy/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:magazy/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SelectLoginScreen extends StatefulWidget {
  const SelectLoginScreen({Key? key}) : super(key: key);
  @override
  State<SelectLoginScreen> createState() => _SelectLoginScreenState();




}

const kColorBg = Color(0xff131512);
class _SelectLoginScreenState extends State<SelectLoginScreen> {

  bool passwvisible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.zero,
            child: AppBar(
              backgroundColor: kColorBg,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: kColorBg,
              statusBarBrightness: Brightness.light, // For iOS: (dark icons)
              statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
          ),
        ),
      ),
    backgroundColor: kColorBg,
    body: SafeArea(
    child: Container(
      height: size.height,
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(child: Container()),
      Container(padding: EdgeInsets.only(left: 80, right: 80),  child:
        Image(image: AssetImage('assets/images/lock.png'),width: 800),),
      Expanded(child: Container()),
      Container(height: 50, width: size.width, child:
      Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [
        Container(
        height: 50,
        width: size.width/2.3,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), shape: BoxShape.rectangle),
        child: Material(
          color: Color(0xff9FE870),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
          borderOnForeground: true,
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
            },
            subtitle: new Text(""),
            title: Text(
              textAlign: TextAlign.center,
              'log_in'.tr().toString(),
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: -1,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff163300)
              ),
            ),
          ),
        ),
      ),
        Container(
          height: 50,
          width: size.width/2.3,
          child: Material(
            color: Color(0xff9FE870),
            borderRadius: BorderRadius.circular(25),
            child: ListTile(
              onTap: () async {

              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
              subtitle: new Text(""),
              title: Text(
                textAlign: TextAlign.center,
                "Войти через сервисы",
                style: const TextStyle(
                    letterSpacing: -1,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                    color: Color(0xff163300)
                ),
              ),
            ),
          ),
        ),
      ],)),
      Container(
        margin: const EdgeInsets.only(top: 16),
        height: 50,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
            onTap: () async {

            },
            subtitle: new Text(""),
            title: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [Icon(Icons.apple), Text(
              textAlign: TextAlign.center,
              'loginapple'.tr().toString(),
              style: const TextStyle(
                letterSpacing: -1,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            )],) ,
          ),
        ),
      ),
      Expanded(child: Container()),
    ]
    ),
    )
    ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }


}