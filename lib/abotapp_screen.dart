import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magazy/home_screen.dart';

class AboutappScreen extends StatefulWidget {
  const AboutappScreen({Key? key}) : super(key: key);

  @override
  State<AboutappScreen> createState() => _AboutappScreenState();
}
const kColorBg = Color(0xffffffff);
class _AboutappScreenState extends State<AboutappScreen> {

  @override
  void initState() {
    super.initState();
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
                'aboutapp'.tr().toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),
              ),
            ],
          ),
      Container(
        margin: const EdgeInsets.only(top: 20,),
            child: Image(image: AssetImage('assets/images/logis.png'),width: size.width),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.01),
              alignment: Alignment.center,
              child:
                    Text(
                      'Исполнитель (продавец): ИП Савва Бартенев Игоревич, Дачная улица, 97, село Подстёпки, Ставропольский район, Самарская область, 445143.',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 26,

                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,

                ),
              ),
            ),
          ),
      Container(
        margin: const EdgeInsets.only(top: 20,),
        child: Text(
          'Версия 1.0',
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w900,
            color: Color(0xff000000),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),

        child: MaterialButton(onPressed: () {   },
          height: 60,
          minWidth: size.width,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          color: Color.fromARGB(255, 250, 184, 142),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
          child: Text("Политика кондифициальности",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ),
      ),
        ],
      ),
    ),
      ),
    );
  }
}
