import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connect_social/model/UDetails.dart';
import 'package:connect_social/model/User.dart';
import 'package:connect_social/res/constant.dart';
import 'package:connect_social/view/screens/account_verification.dart';
import 'package:connect_social/view/screens/login.dart';
import 'package:connect_social/view/screens/widgets/layout.dart';
import 'package:connect_social/view_model/u_details_view_model.dart';
import 'package:connect_social/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) => animateIcon());
      Provider.of<UserViewModel>(context, listen: false).setUser(User());
    });
    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  double widthOfLogo=120.0;
  animateIcon(){
    /*setState(() {

    });
    */
    if(widthOfLogo==120.0){
      widthOfLogo=200.0;
    }else {
      widthOfLogo=120.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    User? user=Provider.of<UserViewModel>(context).getUser;
    print('user.email_verified_at: ${user?.email_verified_at}');
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        0.4,
                        0.6,
                        0.9,
                      ],
                      colors: [
                        Color(0xFFf0f2f5),
                        Color(0xFFf0f2f5),
                        Color(0xFFf0f2f5),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(

                        child: Container(
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    width: widthOfLogo,
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      width: 160,
                                      height: 160,
                                    ),
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOutCirc,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 40),

                                    child:
                                    DefaultTextStyle(

                                      style:
                                      GoogleFonts.robotoSlab(fontSize: 25,fontStyle: FontStyle.italic,color: Colors.grey),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            'Welcome to Connect Social',
                                            speed: const Duration(milliseconds: 100),
                                          ),
                                        ],
                                        totalRepeatCount: 100,
                                        displayFullTextOnTap: true,
                                        stopPauseOnTap: false,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: Constants.authNavigation(context),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              String routeToScreen=snapshot.data;
                              switch (routeToScreen){

                                case 'home':
                                  if(user?.email_verified_at == null){
                                    Future.delayed(Duration.zero, () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccountVerificationScreen()));
                                    });
                                    break;
                                  }
                                  if(user?.email_verified_at != null){
                                    Future.delayed(Duration.zero, () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NPLayout()));
                                    });
                                    break;
                                  }

                                  break;
                                case 'login':
                                  Future.delayed(Duration.zero, () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                  });
                                  break;
                              }
                              return Container();
                            }
                            return Container();
                          }

                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}