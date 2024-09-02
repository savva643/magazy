import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magazy/home_screen.dart';
import 'package:magazy/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getlatloc() async {
    final prefs = await SharedPreferences.getInstance();

    final tk = prefs.getString('token') ?? "0";
    if(tk != "0"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      getlatloc();
    });
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 159, 232, 112),
            Color.fromARGB(255, 159, 232, 112),
          ],
        ),
      ),
      child:  Scaffold(
        //Make sure you make the scaffold background transparent
        backgroundColor: Colors.transparent,
        body: Center(child: Container(padding: EdgeInsets.only(left: 100, right: 100), child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: size.width,
        )),),
      ),
    );
  }
}
