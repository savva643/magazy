import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:magazy/change_language.dart';
import 'package:magazy/account_sccreen.dart';
import 'package:magazy/abotapp_screen.dart';
import 'package:magazy/map.dart';
import 'package:magazy/tovar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'korzina.dart';


const kBgColor = Color(0xFF1604E2);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();




}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  List _langData = [
    {
      'id': '1',
      'img': 'assets/images/usa.jpeg',
      'name': 'English',
    },
    {
      'id': '2',
      'img': 'assets/images/russia.png',
      'name': 'Русский',
    },
  ];
  @override
  void initState()
  {
    postRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/images/logocolor.png'),width: 120),
                ],
              ),
            ),
         ListTile(
         onTap: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));
        },
        leading: const Icon(Icons.account_circle, size: 18,),
        title:  Text('account'.tr().toString(), style: TextStyle(fontSize: 14),),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16,),
      ),
            ListTile(
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeLanguage()));
              },
              leading: const Icon(Icons.translate, size: 18,),
              title:  Text('changelang'.tr().toString(), style: TextStyle(fontSize: 14),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16,),
            ),
            ListTile(
              onTap: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutappScreen()));
              },
              leading: Icon(Icons.info, size: 18,),
              title: Text('aboutapp'.tr().toString(), style: TextStyle(fontSize: 14),),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16,),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: kBgColor,

          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kBgColor,
            statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
            statusBarIconBrightness: Brightness.light, // For Android: (dark icons)
          ),
        ),
      ),

      body: SafeArea(
        child:
        Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF5F6F7),
                  Color(0xffF5F6F7)
                ],
              )),
          child:
          Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
                children: [
                  /// header action icons
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '54-ая Улица, 12>',
                    textAlign: TextAlign.left,
                    
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'
                    ),
                  ),Text(
                    'Доставка 15 минут',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',

                    ),
                  ),
                        ],
              ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                            child: const Icon(
                              Icons.segment,
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12,),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Colors.white),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 70,
                    width: double.infinity,
                    child: Row( children: [Container(padding: EdgeInsets.all(4), height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffF5F6F7)), child: Icon(Icons.search, color: Colors.grey.shade400,),),
                    SizedBox(width: 10,),Expanded(child: Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 16, top: 2), height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffF5F6F7)), child: Text(
                      'search'.tr().toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',

                      ),
                    )))
                    ],)

                  ),

                ],
              ),
            SizedBox(height: 12,),
            Expanded(
                child:  Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _loadGridView(),
                )
            ),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:
        Container(  margin: const EdgeInsets.only(top: 20),
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Material(
            color: Color.fromARGB(255, 159, 232, 112),
            borderRadius: BorderRadius.circular(25),
            child: ListTile(
              onTap: () async {

              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ),
              subtitle: Text(""),
              title: Text(
                textAlign: TextAlign.center,
                "Корзина",
                style: const TextStyle(
                  letterSpacing: -1,
                  fontSize: 14,
                  color: Color.fromARGB(255, 22, 51, 0),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
      ),
            Container(
              height: 110,
              width: size.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, -3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255,255,255),
                      Color.fromARGB(255, 255,255,255)
                    ],
                  )
              ),
              child: ListView(
                children: [
                  MaterialButton(onPressed: () {
                    showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: [
                                Container(
                                  height: 70.0, // Adjust height to match the image height
                                  padding: EdgeInsets.all(16.0),
                                  child: SafeArea(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close, color: Colors.black),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                        Text("Доставка",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Montserrat'
                                          ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(24, 6, 0, 0),
                        child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          child:  Text("Курьер приедет за 10-20 мин.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'
                              ),
                          ),
                        ),
                        Container(
                          child:Text("Режим работы: с 08 до 21",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat'
                              ),),
                        ),
                        ],),),
                      Container(
                        margin: const EdgeInsets.fromLTRB(14, 8, 14, 0),
                        child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Условия",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'
                        ),),
                        Text("Корзина",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat'
                          ),),
                        ],),),
                            Container(
                              margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(onPressed: () { Navigator.pop(context); },
                                height: 60,
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                color: Color.fromARGB(255, 29, 31, 32),
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                                child: Text("Информация о магазинчике",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(onPressed: () { Navigator.pop(context); },
                                height: 60,
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                color: Color.fromARGB(255, 250, 184, 142),
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                                child: Text("Хорошо",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                    },
                    height: 50,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                    child: Center(child:Container(alignment: Alignment.center,child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image(image: AssetImage('assets/images/velosiped.png'),width: 30,),
              Container(margin: EdgeInsets.only(left: 14),child:Text("Доставка 99₽ • Ещё 160₽, и будет 59₽",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),),),],),),),
                  ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),

            child: MaterialButton(onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Korzina())); },
                height: 60,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
                color: Color.fromARGB(255, 250, 184, 142),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                child: Text("Корзина",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                ),),
              ),
          ),
              ],
            ),

            )

          ],
        ),
      ),

      ),
    );
  }


  List _searchedLangData = [];

  final _searchLanguageController = TextEditingController();



  _loadSearchedLanguages(String? textVal) {
    if(textVal != null && textVal.isNotEmpty) {
      final data = _langData.where((lang) {
        return lang['name'].toLowerCase().contains(textVal.toLowerCase());
      }).toList();
      setState(() => _searchedLangData = data);
    } else {
      setState(() => _searchedLangData = _langData);
    }
  }

  _clearSearch() {
    _searchLanguageController.clear();
    setState(() => _searchedLangData = _langData);
  }

  Widget _loadGridView() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 170.0,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      children: List.generate(_searchedLangData.length, (idx) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffF5F6F7),
          child: InkWell(
            splashColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  TovarScreen(vths:_langData[idx]['id'].toString(), sdzsdz: _langData[idx]['name'].toString(),)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10,top: 6),
              child:Text(
                  _langData[idx]['name'],
                  textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.bottomCenter,
              child:SizedBox(
                  width: 110,
                  height: 110,
                  child: CachedNetworkImage(
                    imageUrl: _searchedLangData[idx]['img'],
                  ),
                ),
            ),
                Expanded(child: Container()),
              ],
            ),
          ),
        );
      }),
    );
  }
  Future<http.Response> postRequest () async {
    var urli = Uri.parse("https://magazinchik.keeppixel.store/flutterapi.php?getcategory=1");

    var response = await http.post(urli,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(<String, String>{
        'login': "klkjh",
      }),
    );
    String dff = response.body.toString();
    print(dff);
    setState(() {
      _langData = jsonDecode(dff);
      _searchedLangData = _langData;
    });
    return response;
  }


}




