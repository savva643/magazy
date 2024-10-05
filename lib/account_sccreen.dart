import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magazy/abotapp_screen.dart';
import 'package:magazy/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();




}

const kColorBg = Color(0xffffffff);
class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState()
  {
    super.initState();
    postRequest();
  }

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
    /// header action icons
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 80,
        height: 40,
        child:
        MaterialButton(onPressed: () { Navigator.pop(context); },
          height: 40,
          color: Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40.0)),
          child: Image(image: AssetImage('assets/images/Arrow5.png'),width: 40),
        ),),
    Text(
    'account'.tr().toString(),
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
      color: Colors.black,
    ),
    ),
    ],
    ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
          children: [
      CachedNetworkImage(
        imageUrl: imgurl,
        imageBuilder: (context, imageProvider) => Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text(
          nametxt,
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 24,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
            SvgPicture.asset(
              'assets/images/Vector.svg',
              width: 48.0,
            ),
        ],),
      ),
      ],),),
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            trailing: Icon(Icons.arrow_forward_ios_rounded),

            onTap: () async {

            },
            subtitle: new Text(
              'Ваши предыдущие заказы',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
                    'Заказы',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),


            onTap: () async {

            },
            subtitle: new Text(
              'Адреса куда к вам уже приезжали курьеры',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
              'Адреса',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),


            onTap: () async {

            },
            subtitle: new Text(
              'Бонусы за заказы',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
              'Бонусы',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),


            onTap: () async {

            },
            subtitle: new Text(
              'Добавленные карты в приложение',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
              'Способы оплаты',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),


            onTap: () async {

            },
            subtitle: new Text(
              'Связь с нами по любым вопросам',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
              'Связь с нами & faq',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),


            onTap: () async {

            },
            subtitle: new Text(
              'Связь с нами по любым вопросам',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w200,
                color: Color(0xff000000),
              ),),
            title: Text(
              'Работа с нами',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 22),
        height: 48,
        child: Material(
          color: Color.fromARGB(255, 244, 244, 246),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
            },
            subtitle: new Text(""),
            title: Text(
              textAlign: TextAlign.center,
              'logout'.tr().toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    ]
    ),
    ),
    )
    );
  }

  String nametxt = "_";
  String emailtxt = "name@example.com";
  String imgurl = "https://keeppixel.store/iconprof/standart.png";
  int delxitype = 0;
  Future<http.Response> postRequest () async {
    final prefs = await SharedPreferences.getInstance();
    final tk = prefs.getString('token') ?? "0";
    var urli = Uri.parse("https://kompot.site/getabout?token="+tk);

    var response = await http.post(urli,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(<String, String>{
        'login': "klkjh",
      }),
    );
    String dff = response.body.toString();
    print(dff);
    setState(() {
      nametxt = (jsonDecode(dff))["nick"];
      emailtxt = (jsonDecode(dff))["email"];
      imgurl = (jsonDecode(dff))["img"];
      delxitype = int.parse((jsonDecode(dff))["deluxetype"]);
    });
    return response;
  }
}