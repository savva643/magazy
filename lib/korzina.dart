import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:magazy/home_screen.dart';

const kColorBg = Color(0xffffffff);

class Korzina extends StatefulWidget {
  const Korzina({Key? key}) : super(key: key);

  @override
  State<Korzina> createState() => _KorzinaState();
}

class _KorzinaState extends State<Korzina> {

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
  _KorzinaState();

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
                    Text("Корзина",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'
                      ),),
                    SizedBox(width: 12,),
                    Container( height: 50, width: 50, decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(40)),color: Color(0xffffffff)),)
                  ],),
              ),
              SizedBox(height: 12,),

              Expanded(
                  child:  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),color: Colors.white),
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _loadListView(),
                  )
              ),
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          "220₽ - Вперед! К адресу и оплате",
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

            ],
          ),
        ),

      ),
    );
  }


  List _searchedLangData = [];

  final _searchLanguageController = TextEditingController();




  Widget _loadListView() {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: _searchedLangData.length+1,
      itemBuilder: (BuildContext context, int idx)
      {
        if (idx == 0) {
          return Container(margin: EdgeInsets.fromLTRB(20, 0, 20, 0), padding: EdgeInsets.all(16), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40),),color: Color(0xffF5F6F7)),
            child: Column(children: [
              Text(
                textAlign: TextAlign.center,
                "Доставка 99₽",
                style: const TextStyle(
                  letterSpacing: -1,
                  fontSize: 18,
                  color: Color.fromARGB(255, 22, 51, 0),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Еще 780 и будет 0₽",
                style: const TextStyle(
                  letterSpacing: -1,
                  fontSize: 12,
                  color: Color.fromARGB(255, 22, 51, 0),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],));
        }else{

          return Container(
            margin: const EdgeInsets.only(top: 16), child:
            Dismissible(key: Key(_searchedLangData[idx-1].toString()),
        background: Container(
        alignment: Alignment.centerRight,
        color: const Color.fromARGB(255, 195, 0, 1),
        child: const Icon(Icons.add_rounded, color: Colors.white,),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: null,
          
      child: Container(
            child: Material(

              color: Color(0xffF5F6F7),
              borderRadius: BorderRadius.circular(40),
              child: ListTile(
                contentPadding: EdgeInsets.only(
                    left: 0, right: 0, bottom: 10, top: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                onTap: () async {

                },
                leadingAndTrailingTextStyle: TextStyle(),
                leading: SizedBox(width: 90,
                  height: 60,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: _searchedLangData[idx-1]['img'],
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, bottom: 0, top: 0),
                                  width: 64.0,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: imageProvider),
                                  ),
                                ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),),
                    ],),),
                title: Text(
                  _searchedLangData[idx-1]['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0)
                  ),
                ),
                subtitle: Text(
                  _searchedLangData[idx-1]['cell'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0)
                  ),
                ),
                trailing: Container(margin: EdgeInsets.only(right: 16), alignment: Alignment.center, width: 50, height: 50, decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.all(Radius.circular(40))), child:  Text(
                  _searchedLangData[idx-1]['cell'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0)
                  ),
                )) ,
              ),
            ),
          )));
        }
      },
    );
  }






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

  Future<http.Response> postRequest () async {
    var urli = Uri.parse("https://magazinchik.keeppixel.store/flutterapi.php?getcategortovar=1");

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
