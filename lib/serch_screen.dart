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
import 'package:magazy/tovar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


const kBgColor = Color(0xFF1604E2);

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();




}

class _SearchScreenState extends State<SearchScreen> {
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
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),color: Colors.white),
                    child:
                    Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container( height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffF5F6F7)), child: IconButton(onPressed: (){Navigator.pop(context);}, padding: EdgeInsets.all(0),  icon:  Icon(Icons.arrow_back_rounded, color: Colors.black,)),),
                    SizedBox(width: 12,),
                          Container(padding: EdgeInsets.only(left: 20, right: 20), width: size.width-102, height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color: Color(0xffF5F6F7)), child:
                    TextFormField(
                      controller: _searchLanguageController,
                      onChanged: _loadSearchedLanguages,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.black38),
                        hintText: 'search'.tr().toString(),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.symmetric(vertical: 10), // Убираем смещение по вертикали
                        suffixIcon: _searchLanguageController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                            : null,
                      ),
                    )),
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




