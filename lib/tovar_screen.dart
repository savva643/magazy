import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:magazy/change_language.dart';
import 'package:magazy/account_sccreen.dart';
import 'package:magazy/abotapp_screen.dart';
import 'package:magazy/serch_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


const kBgColor = Color(0xFF1604E2);

class TovarScreen extends StatefulWidget {
  String vths;
  String sdzsdz;
  TovarScreen({super.key, required this.vths, required this.sdzsdz});
  @override
  State<TovarScreen> createState() => _TovarScreenState(vthsd: vths, namik: sdzsdz);

}

class _TovarScreenState extends State<TovarScreen> {
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
  late String vthsd;
  late String namik;
  _TovarScreenState({required this.vthsd,required this.namik});

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
          Container(
          width: size.width,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),color: Colors.white),
          child:
          Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container( height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffF5F6F7)), child: IconButton(onPressed: (){Navigator.pop(context);}, padding: EdgeInsets.all(0),  icon:  Icon(Icons.arrow_back_rounded, color: Colors.black,)),),
              SizedBox(width: 12,),
              Text(namik,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat'
                ),),
              SizedBox(width: 12,),
              Container( height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffF5F6F7)), child: IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen())); }, padding: EdgeInsets.all(0),  icon:  Icon(Icons.search, color: Colors.black,)),)
            ],),
        ),
            SizedBox(height: 12,),
            Expanded(
                child:  Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _loadGridView(),
                )
            ),


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
    double width = MediaQuery.of(context).size.width;
    double vdsd = MediaQuery.of(context).size.height;
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 246.0,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      children: List.generate(_searchedLangData.length, (idx) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 244, 244, 246),
          child: InkWell(
            splashColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
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
                    height: MediaQuery.of(context).size.height * 0.94,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            // Image Background
                            Container(
                              height: 400.0, // Adjust height as needed
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(_langData[idx]['img']),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // Header content
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: ListView(
                              children: [
                                // Add more widgets here
                                Text(_langData[idx]['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'
                                ),),
                                Text('Item 2'),
                                Text('Item 3'),
                                // Add as many items as needed
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          width: width,
                  child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                    height: 44,
                        child: Center(
                          child: Text("Цена",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat'
                            ),),
                        ),
                    ),
                        Container(
                          height: 44,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child:MaterialButton(onPressed: () { Navigator.pop(context); },
                            height: 50,
                            color: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                            child: Text("В корзину"),
                          ),),
                          ],
                  ),),
                        ),
                      ],
                    ),
                  );
                },
              );

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
            Stack(alignment: Alignment.topRight,
              children: [Container(alignment: Alignment.bottomCenter,
              child:SizedBox(
                width: 180,
                height: 180,
                child: CachedNetworkImage(
                  imageUrl: _searchedLangData[idx]['img'],
                ),
              ),
            ),
              Container(
margin: EdgeInsets.all(6),
                height: 40,
                width: 40,
                decoration: BoxDecoration(),
                child:MaterialButton(onPressed: () { },
                  height: 40,
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40.0)),
                  child: Text("+", style: TextStyle(fontSize: 22,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,),),
                ),)
            ],
            ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 10,top: 6),
                  child:Text(
                    _langData[idx]['cell'].toString()+"₽",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 10,bottom: 6),
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
              ],
            ),
          ),
        );
      }),
    );
  }
  Future<http.Response> postRequest () async {
    var urli = Uri.parse("https://magazinchik.keeppixel.store/flutterapi.php?getcategortovar="+vthsd);

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




