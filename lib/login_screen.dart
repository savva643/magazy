import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magazy/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();




}

const kColorBg = Color.fromARGB(255,19, 21, 18);
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: MaterialButton( shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60))), color: Color(0xff363835), onPressed: () {Navigator.pop(context);},  child: Icon(Icons.arrow_back_rounded, color: Color.fromARGB(255, 159, 232, 112),)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 20,),
                    child: Text(
                      'phone_number'.tr().toString(),
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 14,),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kColorBg,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color.fromARGB(255, 137, 138, 136))
                    ),
                    child: TextFormField(
                      controller: _searchServerController,
                      onChanged: _checkem,
                      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),
                        hintText: 'login'.tr().toString(),
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16,),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kColorBg,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color.fromARGB(255, 137, 138, 136))
                    ),
                    child: TextFormField(
                      controller: _searchServerControllerpass,
                      onChanged: _checpass,
                      obscureText: passwvisible,
                      style:  TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),
                        border: InputBorder.none,
                        hintText: 'password'.tr().toString(),
                        hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontWeight: FontWeight.w400,),

                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Material(
                      color: Color.fromARGB(255, 159, 232, 112),
                      borderRadius: BorderRadius.circular(25),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
                        subtitle: Text(""),
                        title: Text(
                          textAlign: TextAlign.center,
                          'log_in'.tr().toString(),
                          style: const TextStyle(
                            letterSpacing: -1,
                            fontSize: 14,
                            color: Color.fromARGB(255, 22, 51, 0),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: Container()),
                  Container(padding: EdgeInsets.only(left: 40, right: 40, bottom: 10), child: Row(children: [RoundCheckBox(
                    onTap: (selected) {
                      setState(() {
                        isChecked = selected!;
                      });
                    },
                    size: 24,
                    border: Border.all(width: 0),
                    uncheckedWidget: Checkbox( value: isChecked, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))), activeColor: Color.fromARGB(255, 159, 232, 112),  onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                    checkedWidget: Checkbox( value: isChecked, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))), activeColor: Color.fromARGB(255, 159, 232, 112),  onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                    animationDuration: Duration(milliseconds: 400),
                    isChecked: isChecked,
                    uncheckedColor: Colors.grey,
                    checkedColor: Color.fromARGB(255, 159, 232, 112),
                  ), SizedBox(width: 10,),
                    Text(
                      textAlign: TextAlign.start,
                      "Получать предложения с акциями с скидками",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xffB3B3B3),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],),),
                  Container(padding: EdgeInsets.only(left: 40, right: 40, bottom: 12), child: Row(children: [RoundCheckBox(
                    onTap: (selected) {
                      setState(() {
                        isChecked2 = selected!;
                      });
                    },
                    size: 24,
                    border: Border.all(width: 0),
                    uncheckedWidget: Checkbox( value: isChecked2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))), activeColor: Color.fromARGB(255, 159, 232, 112),  onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                      });
                    }),
                    checkedWidget: Checkbox( value: isChecked2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))), activeColor: Color.fromARGB(255, 159, 232, 112),  onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                      });
                      }),
                    animationDuration: Duration(milliseconds: 400),
                    isChecked: isChecked2,
                    uncheckedColor: Colors.grey,
                    checkedColor: Color.fromARGB(255, 159, 232, 112),
                  ), SizedBox(width: 10,),
                    Text(
                      textAlign: TextAlign.start,
                      "Делится данными с партнёрами Магазинчика",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xffB3B3B3),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],),),

                  Container(padding: EdgeInsets.only(left: 40, right: 40, bottom: 20), child: Text(
                    textAlign: TextAlign.start,
                    "При продолжении авторизации вы подтверждаете своё согласие с политикой конфиденциальности, условиями сервиса и условиями продажи товаров.",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xffB3B3B3),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                    ),
                  ),)
                ]
            ),
          )
      ),
    );
  }
  bool isChecked = false;
  bool isChecked2 = false;
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
  Future<http.Response> postRequest () async {
    var urli = Uri.parse("http://kompot.site/anlog?login="+ _searchServerController.text.toString()+"&password="+_searchServerControllerpass.text.toString());


    var response = await http.post(urli,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(<String, String>{
        'login': _searchServerController.text.toString(),
        'password': _searchServerControllerpass.text.toString(),
      }),
    );
    String dff = response.body.toString();
    if((jsonDecode(dff))["status"] =="true"){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', (jsonDecode(dff))["token"]);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    }else{
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("wrongpass".tr().toString()),
      ));
    }

    return response;
  }

  _checpass(String? textVal) {
    if (textVal != null && textVal.isNotEmpty) {
      setState(() => passw = true);
    }else{
      setState(() => passw = false);
    }
  }
}