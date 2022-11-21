import 'package:e_ticaret_app/product/constants/constant.dart';
import 'package:e_ticaret_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Grock.toRemove( LoginView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.darkWhite,
      body: Center(
        child: Image.asset("assets/im_splash.png"),
      ),
    );
  }
}
