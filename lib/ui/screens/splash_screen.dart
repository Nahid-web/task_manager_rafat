import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_rafat/ui/controller/auth_controller.dart';


import 'package:task_manager_rafat/ui/screens/login_screen.dart';
import 'package:task_manager_rafat/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> gotoLogin() async{
   final bool isLoggedIn = await AuthController.checkAuthState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
        ),
      );
    });
  }
  // gotoLogin() {
  //
  //   Future.delayed(const Duration(seconds: 2)).then((value) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>  const LoginScreen() ,
  //       ),
  //     );
  //   });
  // }

  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset('assets/images/logo.svg'),
        ),
      ),
    );
  }
}
