import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magazy/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();




}

const kColorBg = Color(0xffffffff);
class _LoginScreenState extends State<LoginScreen> {


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
    child: Padding(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
    child: Column(
    children: [
      Positioned(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.01),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/images/logo.png', width: 50),
                ),
      Container(
        child:
                Text(
                  'VoyFy',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 34,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w900,
                    color: Color(0xff000000),
                  ),
                ),
        margin: EdgeInsets.only(left: 6),
      ),
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 30,),
        child: Text(
          'loginvoufy'.tr().toString(),
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 34,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w700,
            color: Color(0xff000000),
          ),
        ),
      ),
      Container(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'via'.tr().toString(),
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10,),
              child: GradientText(
                'Keep Pixel',
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w700,
                ),
                colors: [Color(0xff0038FF), Color(0xff829CFB)],
              ),
            ),
          ],
       ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 20,),
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: _searchServerController,
          onChanged: _checkem,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'login'.tr().toString(),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Gilroy', fontWeight: FontWeight.w300,),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 16,),
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: _searchServerControllerpass,
          onChanged: _checpass,
          obscureText: passwvisible,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'password'.tr().toString(),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Gilroy', fontWeight: FontWeight.w300,),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                passwvisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  passwvisible = !passwvisible;
                });
              },
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            onTap: () async {
              if(email == true && passw == true) {
                postRequest();
              }else if(email == false){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  content: Text("enterlog".tr().toString()),
                ));
              }else if(passw == false){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                  content: Text("enterpass".tr().toString()),
                ));
              }
            },
            subtitle: new Text(""),
            title: Text(
                textAlign: TextAlign.center,
              'log_in'.tr().toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 20,),
        child: Text(
          'or'.tr().toString(),
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 18,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w300,
            color: Color(0xff000000),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 22),
        height: 48,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            onTap: () async {

            },
            subtitle: new Text(""),
            title: Text(
              textAlign: TextAlign.center,
                Platform.isIOS ? 'loginapple'.tr().toString() : 'logingoogle'.tr().toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 16),
        height: 48,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            onTap: () async {

            },
            subtitle: new Text(""),
            title: Text(
              textAlign: TextAlign.center,
              'loginservice'.tr().toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ]
    ),
    )
    ),
    );
  }
  @override
  void dispose() {
    _searchServerController.dispose();
    _searchServerControllerpass.dispose();
    super.dispose();
  }
  final _searchServerController = TextEditingController();
  final _searchServerControllerpass = TextEditingController();
  bool email = false;
  bool passw = false;
  _checkem(String? textVal) {
    if (textVal != null && textVal.isNotEmpty) {
      setState(() => email = true);
    }else{
      setState(() => email = false);
    }
  }
  Future<void> postRequest () async {
    var urli = Uri.parse("https://kompot.site/anlog?login="+_searchServerController.text.toString()+"&password="+_searchServerControllerpass.text.toString());

      var response = await http.get(urli);
      String dff = response.body.toString();

      setState(() async {
        dynamic _langData = jsonDecode(dff);
        print(_langData);
        if(_langData['status'] == "true"){
          print("gkjhjk"+_langData['token']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', (_langData)["token"]);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("wrongpass".tr().toString()),
      ));
    }
      });
  }


  _checpass(String? textVal) {
    if (textVal != null && textVal.isNotEmpty) {
      setState(() => passw = true);
    }else{
      setState(() => passw = false);
    }
  }
}